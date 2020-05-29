const clickSmileyLink = () => {
  const smileyRadioBtns = document.querySelectorAll('#smiley-container input.radio_buttons')
  if (smileyRadioBtns) {
    smileyRadioBtns.forEach((radioBtn) => {
      radioBtn.addEventListener('change', (event) => {
        // console.log(event)
        const value = event.currentTarget.value
        console.log(value)
        document.querySelector(`#${value}-link`).click()
      })
    })
  }
}

export { clickSmileyLink }
