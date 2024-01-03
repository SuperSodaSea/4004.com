<script setup lang="ts">
const client = 'ca-pub-9316322743749738';
const slot = '9108909021';
</script>

<template>
    <component
        :is="'script'"
        async
        :src="'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=' + client"
        crossorigin="anonymous">
    </component>
    <ins
        class="adsbygoogle"
        style="display: inline-block; width: 120px; height: 600px"
        :data-ad-client="client"
        :data-ad-slot="slot">
    </ins>
    <component :is="'script'">
        (adsbygoogle = window.adsbygoogle || []).push({});
    </component>
</template>
