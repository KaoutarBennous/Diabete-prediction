/*----------header animation*/
const header=document.querySelector("header");
const ml_section=document.querySelector(".milestones");
const ml_counters=document.querySelectorAll(".number span");

window.addEventListener("scroll",()=>{
        if(!mlplayed) mlcounters();
      });

let mlplayed=false;
function mlcounters(){
  if(!hasReached(ml_section)) return;
  mlplayed=true;
  ml_counters.forEach((ctr)=>{
    let target= +ctr.dataset.target;
    setTimeout(()=>{
      updateCount(ctr,target);
 },400);

  });

}



function hasReached(el){
 let topPosition=el.getBoundingClientRect().top;
 if(window.innerHeight>= topPosition+el.offsetHeight) return true;
 return false;
}
function updateCount(num,maxNum){
     let currentNum= +num.innerText;
     if(currentNum < maxNum){
       num.innerText=currentNum+1;
       setTimeout(()=>{
            updateCount(num,maxNum);
       },12);
     }
}

function stickyNavbar(){
  header.classList.toggle("scrolled",window.pageYOffset>0);

}
stickyNavbar();
window.addEventListener("scroll",stickyNavbar);

/*----scroll reval---*/
let sr=ScrollReveal({
  duration:2500,
  distance: "60px",

});
sr.reveal(".left",{deplay:600});
sr.reveal(".right",{origin:"top",deplay:700});
sr.reveal(".section-header",{origin:"top",deplay:800});
sr.reveal(".container_s",{origin:"bottom",deplay:600});
sr.reveal(".diabete_info",{origin:"right",deplay:600});
sr.reveal(".diabete_grid",{origin:"bottom",deplay:600});
sr.reveal(".graph",{origin:"bottom",deplay:600});
sr.reveal(".diagram_text",{origin:"right",deplay:600});




var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("box-heading");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}
    if (n < 1) {slideIndex = slides.length}
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
    }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}



