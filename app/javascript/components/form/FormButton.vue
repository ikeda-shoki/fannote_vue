<template>
  <div id="form-button">
    <button type="submit" class="button" value="submit">
      {{ buttonName }}
    </button>
  </div>
</template>

<script>
export default {
  props : {
    buttonName: { type: String, required: true }
  }
}
</script>

<style lang="scss" scoped>
  #form-button {
    text-align: center;
  }
</style>