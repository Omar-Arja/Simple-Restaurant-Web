var sslideImg =document.getElementById("slideImg");
var images = new Array(
    "images/slider1.jpg",
    "images/blue.webp",
    "images/burrito.webp",
    "images/comp.jpg",
    "images/cook.webp",
    "images/cook2.jpg",
    "images/cookies4.jpg",
);
var len =images.length;
var i=0;
function slider(){
     if( i>len-1){
    i=0;
}
slideImg.src= images[i];
i++;
setTimeout('slider()',3000);
}



const menu = [
    {
      "name": "Pizza",
      "description": "Delicious dish description.",
      "price": 10,
      "image": "img/pizza.jpg"
    }
  ];
  
  // Example: Dynamically render on the page
  menu.forEach(item => {
    console.log(`Dish: ${item.name}, Price: $${item.price}`);
  });

  var sslideImg =document.getElementById("slideImg");
  var images = new Array(
      "images/slider1.jpg",
      "images/blue.webp",
      "images/burrito.webp",
      "images/comp.jpg",
      "images/cook.webp",
      "images/cook2.jpg",
      "images/cookies4.jpg",
  );
  var len =images.length;
  var i=0;
  function slider(){
       if( i>len-1){
      i=0;
  }
  slideImg.src= images[i];
  i++;
  setTimeout('slider()',3000);
  }


//about us
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
  crossorigin="anonymous"></script>

  