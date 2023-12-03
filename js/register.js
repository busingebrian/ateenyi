
let usernameRef = document.getElementById("username");
let passwordRef = document.getElementById("password");
let passwordRefReEnter = document.getElementById("re-enter");
let eyeL = document.querySelector(".eyeball-l");
let eyeR = document.querySelector(".eyeball-r");
let handL = document.querySelector(".hand-l");
let handR = document.querySelector(".hand-r");

let normalEyeStyle = () => {
  eyeL.style.cssText = "left: 0.6em; top: 0.6em;";
  eyeR.style.cssText = "right: 0.6em; top: 0.6em;";
};

let normalHandStyle = () => {
  handL.style.cssText =
    "height: 2.81em; top: 7.0em; left: 7.5em; transform: rotate(0deg);";
  handR.style.cssText =
    "height: 2.81em; top: 7.0em; right: 7.5em; transform: rotate(0deg);";
};

// When clicked on username input
usernameRef.addEventListener("focus", () => {
  eyeL.style.cssText = "left: 0.75em; top: 0.12em;";
  eyeR.style.cssText = "right: 0.75em; top: 0.12em;";
  normalHandStyle();
});

// When clicked on password input
passwordRef.addEventListener("focus", () => {
  handL.style.cssText =
    "height: 6.56em; top: 2.90em; left: 11.75em; transform: rotate(-155deg);";
  handR.style.cssText =
    "height: 6.56em; top: 2.90em; right: 11.75em; transform: rotate(155deg);";
  normalEyeStyle();
});


// When clicked on re-enter password input
passwordRefReEnter.addEventListener("focus", () => {
    handL.style.cssText =
      "height: 6.56em; top: 2.90em; left: 11.75em; transform: rotate(-155deg);";
    handR.style.cssText =
      "height: 6.56em; top: 2.90em; right: 11.75em; transform: rotate(155deg);";
    normalEyeStyle();
  });

// When clicked outside username and password input
document.addEventListener("click", (e) => {
  let clickedElem = e.target;
  if (clickedElem != usernameRef && clickedElem != passwordRef) {
    normalEyeStyle();
    normalHandStyle();
  }
});



// toggle password visibility
const togglePassword = document.querySelector("#togglePassword");
const togglePassword2 = document.querySelector("#togglePassword2");
const eye1 = document.querySelector("#eye1");
const eye2 = document.querySelector("#eye2");

// toggle the type attribute 1st pasword
eye1.addEventListener("click", function (e) {
    const type = passwordRef.getAttribute("type") === "password" ? "text": "password";
    passwordRef.setAttribute("type", type);
    // toggle the icon
this.classList.toggle("fa-eye-slash")
});

// toggle the type attribute 2nd pasword
eye2.addEventListener("click", function (e) {
    const type = passwordRefReEnter.getAttribute("type") === "password" ? "text": "password";
    passwordRefReEnter.setAttribute("type", type);
    // toggle the icon
this.classList.toggle("fa-eye-slash")
});

//validation event

function validateForm(){
  // var username = document.register.username.value;
  // var password = document.register.password.value;
  // var rePassword = document.register.password.value;

  if(usernameRef == null || usernameRef == ""){
    alert("Username can't be blank");
    return false;
  } else if(passwordRef.length < 5){
    alert("Password must be at least 5 characters long");
    return false;
  }else if(passwordRefReEnter != passwordRef){
    alert("passwords must be same");
    return false;
  }
}