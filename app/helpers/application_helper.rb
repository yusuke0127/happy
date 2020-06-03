module ApplicationHelper
  def mood_fontawesome(rating)
    case rating
    when "awful" then "<svg class='awful-3d animate-bounce' width='44px' height='44px' viewBox='0 0 44 44' version='1.1' preserveAspectRatio='xMinYMin meet' class='svg-content'>
                <g id='awful-3d' stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' transform='translate(0, 0)'>
                  <circle id='body'  fill='#6E2594' cx='22' cy='22' r='22'></circle>
                  <g id='face' transform='translate(13.000000, 20.000000)'>
                    <g class='face'>
                      <path d='M7,4 C7,5.1045695 7.8954305,6 9,6 C10.1045695,6 11,5.1045695 11,4' class='mouth' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <ellipse fill='#E23D18' cx='21.8941176' cy='26.4390244' rx='1.69411765' ry='0.780487805' fill='#2C0E0F'></ellipse>
                      <path d='M4,7 l-4,4'  class='left-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M0,7 l4,4'  class='left-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M18,7 l-4,4'  class='right-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M14,7 l4,4'  class='right-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                    </g>
                  </g>
                </g>
              </svg>"
    when "meh" then "<svg class='awful-3d animate-bounce' width='44px' height='44px' viewBox='0 0 44 44' version='1.1' preserveAspectRatio='xMinYMin meet' class='svg-content'>
                <g id='awful-3d' stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' transform='translate(0, 0)'>
                  <circle id='body'  fill='#6E2594' cx='22' cy='22' r='22'></circle>
                  <g id='face' transform='translate(13.000000, 20.000000)'>
                    <g class='face'>
                      <path d='M7,4 C7,5.1045695 7.8954305,6 9,6 C10.1045695,6 11,5.1045695 11,4' class='mouth' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <ellipse fill='#E23D18' cx='21.8941176' cy='26.4390244' rx='1.69411765' ry='0.780487805' fill='#2C0E0F'></ellipse>
                      <path d='M4,7 l-4,4'  class='left-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M0,7 l4,4'  class='left-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M18,7 l-4,4'  class='right-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                      <path d='M14,7 l4,4'  class='right-eye' stroke='#2C0E0F' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' transform='translate(9.000000, 5.000000) rotate(-180.000000) translate(-9.000000, -5.000000) '></path>
                    </g>
                  </g>
                </g>
              </svg>"
    when "neutral" then "far fa-smile"
    when "happy" then "far fa-laugh-beam"
    when "fabulous" then "far fa-grin-hearts"
    else
      "fas fa-times"
    end
  end
end
