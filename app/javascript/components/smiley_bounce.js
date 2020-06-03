// const clickSmileyLink = () => {
//   const smileyRadioBtns = document.querySelectorAll('#smiley-container input.radio_buttons')
//   if (smileyRadioBtns) {
//     smileyRadioBtns.forEach((radioBtn) => {
//       radioBtn.addEventListener('change', (event) => {
//         // console.log(event)
//         const value = event.currentTarget.value
//         console.log(value)
//         document.querySelector(`#${value}-link`).click()
//       })
//     })
//   }
// }

const smileyAnimate = () => {
  const smileyDivs = document.querySelectorAll('#smiley-container label div')
  console.log(smileyDivs)
  smileyDivs.forEach((smileyDiv) => {
    smileyDiv.addEventListener('click', (event) =>{
      event.preventDefault();
      console.log(event);
      const div = event.currentTarget
      console.log(div.parentElement.previousElementSibling);
      div.classList.toggle("smiley-svg-div");
      setTimeout(() => {
        div.parentElement.previousElementSibling.click()}, 2000);
    })
  })
}


export { smileyAnimate }


// Click
// add animation on click
// play the animation
// move to next page after the animation
