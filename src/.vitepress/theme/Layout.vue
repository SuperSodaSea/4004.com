<script setup lang="ts">
import { useData } from 'vitepress';
import type { PageData } from 'vitepress';
import type { Ref } from 'vue';

import GoogleAdSense from './GoogleAdSense.vue';


interface Frontmatter {
    layout?: 'default' | 'home';
    copyright?: string;
};


const { frontmatter, page } = useData() as {
    frontmatter: Ref<Frontmatter>,
    page: Ref<PageData>,
};

function relativePath(path: string): string {
    const level = page.value.relativePath.split('/').length - 1;
    if (level === 0) return '.' + path;
    else return '../'.repeat(level).slice(0, -1) + path;
}
</script>

<template>
    <link rel="stylesheet" type="text/css" :href="relativePath('/gila/gila-screen.css')" media="screen" title="Gila (screen)"/>
    <link rel="stylesheet" type="text/css" :href="relativePath('/gila/gila-print.css')" media="print"/>
    <component :is="'style'">
    .header-anchor {
        display: none;
    }
    .sidebar-item {
        color: rgb(166, 140, 83);
    }
    </component>
    <div id="top">
        <a href="#main-copy" class="doNotDisplay doNotPrint">Skip to main content.</a>
    </div>
    <div id="header">
        <h1 class="headerTitle">
            <a :href="relativePath('/')" title="Browse to homepage" v-if="frontmatter.layout === 'home'">Intel 4004 &mdash; 50th Anniversary Project</a>
            <a :href="relativePath('/')" title="Browse to homepage" v-else>4004</a>
        </h1>
        <div class="subHeader">
            <div align="left">
                <span class="doNotDisplay">Navigation: </span>
                <a :href="relativePath('/links.html')">More Information</a> |
                <a :href="relativePath('/#credits')">Credits</a> |
                <a :href="relativePath('/contact.html')">Contact Us</a> |
                <a :href="relativePath('/about.html')">About Us</a>
            </div>
        </div>
    </div>
    <div class="leftSideBar" v-if="frontmatter.layout === 'home'">
        <p class="sideBarTitle">Quick Links</p>
        <ul>
            <li class="sidebar-item"><a :href="relativePath('/#downloads')">Cool Downloads</a></li>
            <li><a :href="relativePath('/#FAQ')" class="sidebar-item">FAQs</a></li>
            <li class="sidebar-item"><a :href="relativePath('/#exhibit')">Exhibit Project</a></li>
        </ul>
        <p class="sideBarTitle">Community Links</p>
        <ul>
            <li class="sidebar-item">
                <a href="https://retrocomputingforum.com/">Retro Computing Forum</a>
            </li>
            <li class="sidebar-item">
                <a href="http://insanity4004.blogspot.com/">Insanity4004: 4004 in an FPGA</a>.
                Links to <a href="http://opencores.org/project,mcs-4"><u>OpenCores</u></a> Verilog code, schematics.
            </li>
            <li class="sidebar-item">
                <a href="http://www.visual6502.org/">Visual 6502 Project</a>
            </li>
            <li class="sidebar-item">
                <a href="http://www.intel4004.com/">Federico Faggin's 4004 history blog</a>
            </li>
            <li class="sidebar-item">
                <a href="http://ht.homeserver.hu/html/emulatorfastz80.html">FastZ80: Z80 Emulator</a>
            </li>
            <li class="sidebar-item">
                <a href="https://www.ithistory.org/">IT History Society</a>
            </li>
        </ul>
        <p class="sideBarTitle">Advertisements</p>
        <div style="text-align: center;">
            <GoogleAdSense/>
        </div>
    </div>
    <div class="leftSideBar" v-else>
        <p class="sideBarTitle">Quick Links</p>
        <ul>
            <li class="sidebar-item"><a :href="relativePath('/')">4004 Home</a></li>
            <li class="sidebar-item"><a :href="relativePath('/#downloads')">Cool Downloads</a></li>
        </ul>
        <p class="sideBarTitle">Advertisements</p>
        <div style="text-align: center;">
            <GoogleAdSense/>
        </div>
    </div>
    <div class="rightSideBar" v-if="frontmatter.layout === 'home'">
        <p class="sideBarTitle">News</p>
        <div class="sideBarText">
            <strong>Nov 15, 2023</strong><br>
            <span class="sidebar-item">
                Klaus Scheffler finishes his
                <a :href="relativePath('/hackaday23/')">
                complete 4-bit computer (CPU+RAM+I/O) based on the Intel 4004 schematics using discrete transistors</a>.
                Computes digits of Pi in stand-alone operation.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Feb 20, 2023</strong><br>
            <span class="sidebar-item">
                Klaus Scheffler and Lajos Kintli build the first, fully functional Intel 4004 using discrete transistors.
                They validated the design by running the original Busicom 141-PF firmware to print the square-root of 2.
                This tests <em>a lot</em>.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2022</strong><br>
            <span class="sidebar-item">
                Lajos Kintli repackages his <a :href="relativePath('/assets/i400x_analyzer_repacked_20221111.zip')">MCS-4 analyzer / simulator</a>.
                Has win64 executable, verified 4004 mask artwork, transistor netlist.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Feb 8, 2021</strong><br>
            <span class="sidebar-item">
                Federico Faggin publishes his memoir in English: <a href="http://siliconthebook.com"><em>Silicon</em></a>
                (Also in Italian as <em>Silicio</em>).
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2020</strong><br>
            <span class="sidebar-item">
                Erturk Kocalar releases his <a href="http://8bitforce.com/projects/4004/">4004 Retroshield</a> and Busicom calculator tech summary.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2015</strong><br>
            <span class="sidebar-item">
                The team verifies the <a :href="relativePath('/2015-news.html')">newly re-drawn, scalable mask artwork and designed a newly revised calculator replica using vintage chips</a>.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2009</strong><br>
            <span class="sidebar-item">
                Lajos Kintli releases the <a target="_blank" :href="relativePath('/mcs4-masks-schematics-sim.html')">complete set of schematics and artwork for the MCS-4 chip family plus his improved simulator</a>.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2008</strong><br>
            <span class="sidebar-item">
                Bill Kotaska builds <a :href="relativePath('/busicom-replica.html')">Busicom 141-PF calculator replica</a> and releases <a :href="relativePath('/busicom-schematics-and-simulator.html')">schematics</a>.
                Tim McNerney releases his <a :href="relativePath('/busicom-schematics-and-simulator.html')">Shinshu Seiki Model-102 printer emulator for PIC18F2320</a>.
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2007</strong><br>
            <span class="sidebar-item">
                Team recreates "source code" and releases cool Busicom 141-PF calculator simulator
            </span>
        </div>
        <div class="sideBarText">
            <strong>Nov 15, 2006</strong><br>
            <span class="sidebar-item">
                <a :href="relativePath('/slashdot.html')">Credits</a> from the edited-out-of-the <a href="https://slashdot.org/" target="_blank">slashdot-article</a> department.
            </span>
        </div>
        <div class="sideBarText">
            <p>
                <strong>Nov 15, 1971</strong><br>
                <a :href="relativePath('/4004-ad.html')">MCS-4 (aka 4004 family) product announcement.</a><br>
            </p>
        </div>
        <a :href="relativePath('/moreNews.html')" class="more">more news »</a>
        <p class="sideBarTitle">Featured Downloads</p>
        <div class="sideBarText">
            <a :href="relativePath('/2009/Busicom-141PF-Calculator_asm_rel-1-0-1.txt')" target="_blank">
                Busicom 141-PF calculator firmware, recreated "source code"
            </a>
        </div>
        <div class="sideBarText">
            <a :href="relativePath('/assets/busicom-141pf-simulator-w-flowchart-071113.zip')">
                Busicom 141-PF calculator simulator
            </a>
        </div>
    </div>
    <div id="main-copy">
        <Content/>
    </div>
    <div id="footer">
        <div class="doNotDisplay">
            <a :href="relativePath('/')">Tell a Friend</a> |
            <a :href="relativePath('/')">Privacy Policy</a> |
            <a :href="relativePath('/')">Site Map</a> |
            <a :href="relativePath('/')">Feedback</a> |
            <a :href="relativePath('/')">Help</a>
        </div>
        <div>{{ frontmatter.copyright }}</div>
    </div>
</template>
