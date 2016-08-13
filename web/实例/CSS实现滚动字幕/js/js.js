function setText(event){
  event.preventDefault();
  leftText.innerText = textsource.value.toUpperCase();
  rightText.innerText = textsource.value.toUpperCase();
}
var leftText = document.querySelector("#marquee div:first-of-type span");
var rightText = document.querySelector("#marquee div:last-of-type span");
var textsource = document.getElementById("textsource");
setText();