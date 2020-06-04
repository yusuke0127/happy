const changeCheckFont = () => {
  const checkFontBtn = document.querySelector('.form-btn-container .form-btn')
  console.log(checkFontBtn);
  if (checkFontBtn) {
    checkFontBtn.addEventListener('click', (event) => {
      // console.log(event);
      // console.log(event.currentTarget);
      const font = document.querySelector('.form-btn-container .form-btn i')
      // const font = event.currentTarget;
      // console.log(font);
      font.className = 'fas fa-spinner fa-spin';
    })
  }
}


export { changeCheckFont }
