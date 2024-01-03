import { copyFile, mkdir, readdir, rm, stat } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { defineConfig } from 'vitepress';
import type { Plugin } from 'vite';


const SRC_ROOT = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');


async function copyAssets(targetRootPath: string) {
    const emit = async (assetsPath: string) => {
        const relative = path.relative(SRC_ROOT, assetsPath).replace('\\', '/');
        const targetPath = path.join(targetRootPath, relative);
        await mkdir(path.dirname(targetPath), { recursive: true });
        await copyFile(assetsPath, targetPath);
    }
    const visit = async (directoryPath: string) => {
        const dirents = await readdir(directoryPath, { withFileTypes: true });
        const promises = [];
        for (const dirent of dirents) {
            if (directoryPath === SRC_ROOT && dirent.name === '.vitepress')
                continue;
            const direntPath = path.join(directoryPath, dirent.name);
            if (dirent.isFile()) {
                if (!dirent.name.endsWith('.md'))
                    promises.push(emit(direntPath));
            } else if (dirent.isDirectory())
                promises.push(visit(direntPath));
        }
        await Promise.all(promises);
    };
    await visit(SRC_ROOT);
}


function rollupPluginKeepAssets(): Plugin {
    const RESOLVE_ID_PREFIX = '\0keep-assets:';
    return {
        name: 'rollup-plugin-keep-assets',
        resolveId: {
            order: 'pre',
            async handler(source, importer) {
                if (!importer) return;
                if (!source.startsWith('./') && !source.startsWith('../')) return;
                const resolved = path.resolve(path.dirname(importer), source);
                const relative = path.relative(SRC_ROOT, resolved);
                if (!relative || relative.startsWith('..') || path.isAbsolute(relative)) return;
                if (!path.relative(path.join(SRC_ROOT, '.vitepress'), resolved).startsWith('..')) return;
                if (/.md$/i.test(relative)) return;
                if (!(await stat(resolved)).isFile()) return;
                return RESOLVE_ID_PREFIX + source;
            },
        },
        load: {
            order: 'pre',
            async handler(id) {
                if (!id.startsWith(RESOLVE_ID_PREFIX)) return;
                const url = id.slice(RESOLVE_ID_PREFIX.length);
                return `export default ${ JSON.stringify(url) };`;
            },
        },
    };
}

export default defineConfig({
    mpa: true,
    title: '4004.com',
    titleTemplate: ':title',
    description: '4004.com',
    ignoreDeadLinks: true,
    async buildEnd(siteConfig) {
        await copyAssets(siteConfig.outDir);
        for (const file of [ 'hashmap.json', 'package.json' ])
            await rm(path.join(siteConfig.outDir, file));
    },
    vite: {
        plugins: [ rollupPluginKeepAssets() ],
        build: {
            assetsInlineLimit: 0,
            rollupOptions: {
                output: {
                    assetFileNames() {
                        throw Error('Not allowed');
                    },
                },
            },
        },
    },
});
