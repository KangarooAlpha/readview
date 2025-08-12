import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    new Swiper(this.element, {
      loop: true,
      navigation: {
        nextEl: this.element.querySelector('.swiper-button-next'),
        prevEl: this.element.querySelector('.swiper-button-prev'),
      },
      pagination: {
        el: this.element.querySelector('.swiper-pagination'),
        clickable: true,
      },
    })
  }
}