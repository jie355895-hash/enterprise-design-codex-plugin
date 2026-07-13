<template>
  <aside class="info-drawer">
    <h2>{{title}}</h2>
    <section v-for="item in sections" :key="item.name">
      <h3>{{item.name}}</h3>
      <p>{{item.content}}</p>
    </section>
  </aside>
</template>

<script setup>
defineProps({
 title:String,
 sections:Array
})
</script>
