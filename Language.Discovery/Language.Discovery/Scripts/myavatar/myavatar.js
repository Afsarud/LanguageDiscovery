var $centerImg = $("#myavatar-center-image");
var $panelChoices = $("#myavatar-choices-panel");
var $panelTitle = $("#myavatar-panel-title");

// Set localStorage with data from server
$(document).ready(function(){
  // Initialise myAvtar localStorage
  if(!isAvatarLocalStorageSet()){
    if(false){ // data exist in DB
      // Initialise based on DB
    } else{
      localStorage.setItem('myavatar-gender', 'male');
      localStorage.setItem('myavatar-hairstyle', 1);
      localStorage.setItem('myavatar-haircolor', 1);
      localStorage.setItem('myavatar-skincolor', 0);
    }
  }

});

// When 'Change my avatar' button is clicked
$("#btnChangeAvatar").on("click", function(){
  var centerImgUrl = getCenterImgUrl;

  $centerImg.attr("src", centerImgUrl);
  $panelTitle.text(myavatarSettings[0]);
  $panelChoices.empty();
  selectableBuilder(myavatarGender);

  // Next btn clicked
  $('#myavatar-panel-btn-next').on('click', function(){
    var currentIndex = arrayElementIndex($panelTitle.text(), myavatarSettings);
    var nextIndex = currentIndex + 1;

    if(myavatarSettings[nextIndex]){
      $panelTitle.text(myavatarSettings[nextIndex]);
      selectableUpdate(nextIndex);
    }
  });

  // Previous btn clicked
  $('#myavatar-panel-btn-prev').on('click', function(){
    var currentIndex = arrayElementIndex($panelTitle.text(), myavatarSettings);
    var prevIndex = currentIndex - 1;

    if(myavatarSettings[prevIndex]){
      $panelTitle.text(myavatarSettings[prevIndex]);
      selectableUpdate(prevIndex);
    }
  });

  // Selectables img clicked
  $(".myavatar-selectable").on("click", function(){
    var currentIndex = arrayElementIndex($panelTitle.text(), myavatarSettings);
    var selectedAvatarURL =  $(this).children().attr("src");
    
    $centerImg.attr("src", selectedAvatarURL);
    attributeUpdate(selectedAvatarURL, currentIndex);
  });
});

var attributeUpdate = function(avatarURL, attribute){
  var avatarUrlParts = avatarURL.split("/");
  switch(attribute){
    case 0:
      localStorage.setItem('myavatar-gender', avatarUrlParts[3]);
      break;
    case 1:
      localStorage.setItem('myavatar-hairstyle', avatarUrlParts[4].charAt(9));
      break;
    case 2:
      localStorage.setItem('myavatar-haircolor', avatarUrlParts[5].charAt(9));
      break;
    case 3:
      localStorage.setItem('myavatar-skincolor', avatarUrlParts[6].charAt(0));
      break;
  }
}

var selectableUpdate = function(attribute){
  $panelChoices.empty();

  switch(attribute){
    case 0:
      selectableBuilder(myavatarGender);
      break;
    case 1:
      if(localStorage.getItem("myavatar-gender") === "male"){
        selectableBuilder(myavatarMaleHairstyle);
      } else if(localStorage.getItem("myavatar-gender") === "female"){
        selectableBuilder(myavatarFemaleHairstyle);
      }
      break;
    case 2:
      if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 1){
        selectableBuilder(myavatarMaleHairstyleOneHaircolor);
      }
      else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 2){
        selectableBuilder(myavatarMaleHairstyleTwoHaircolor);
      }
      else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 1){
        selectableBuilder(myavatarFemaleHairstyleOneHaircolor);
      }
      else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 2){
        selectableBuilder(myavatarFemaleHairstyleTwoHaircolor);
      }
      break;
    case 3:
      if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 1){
        selectableBuilder(myavatarMaleHairstyleOneHaircolorOneSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 2){
        selectableBuilder(myavatarMaleHairstyleOneHaircolorTwoSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 3){
        selectableBuilder(myavatarMaleHairstyleOneHaircolorThreeSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 1){
        selectableBuilder(myavatarMaleHairstyleTwoHaircolorOneSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 2){
        selectableBuilder(myavatarMaleHairstyleTwoHaircolorTwoSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "male" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 3){
        selectableBuilder(myavatarMaleHairstyleTwoHaircolorThreeSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 1){
        selectableBuilder(myavatarFemaleHairstyleOneHaircolorOneSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 2){
        selectableBuilder(myavatarFemaleHairstyleOneHaircolorTwoSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 1 && localStorage.getItem("myavatar-haircolor") == 3){
        selectableBuilder(myavatarFemaleHairstyleOneHaircolorThreeSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 1){
        selectableBuilder(myavatarFemaleHairstyleTwoHaircolorOneSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 2){
        selectableBuilder(myavatarFemaleHairstyleTwoHaircolorTwoSkincolor);
      } else if(localStorage.getItem("myavatar-gender") === "female" && localStorage.getItem("myavatar-hairstyle") == 2 && localStorage.getItem("myavatar-haircolor") == 3){
        selectableBuilder(myavatarFemaleHairstyleTwoHaircolorThreeSkincolor);
      }
      break;
  }

  // Selectables img clicked
  $(".myavatar-selectable").on("click", function(){
    var currentIndex = arrayElementIndex($panelTitle.text(), myavatarSettings);
    var selectedAvatarURL =  $(this).children().attr("src");
    
    $centerImg.attr("src", selectedAvatarURL);
    attributeUpdate(selectedAvatarURL, currentIndex);
  });
}

var selectableBuilder = function(myavatarCategory){
  $panelChoices

  for(var i=0; i<myavatarCategory.length; i++){
    $panelChoices.append(
      "<button class='myavatar-selectable' style='border: none;'>" +
        "<img src='" + myavatarCategory[i] + "' height='70' width='70'>" +
      "</button>"
    );
  }
}

var getCenterImgUrl = function(){
  var gender = localStorage.getItem('myavatar-gender');
  var hairstyle = localStorage.getItem('myavatar-hairstyle');
  var haircolor = localStorage.getItem('myavatar-haircolor');
  var skincolor = localStorage.getItem('myavatar-skincolor');
  var imgURL = "";

  imgURL = 
    "../Images/my-avatar/" +
    gender + "/" +
    "hairstyle" + hairstyle + "/" +
    "haircolor" + haircolor + "/" +
    skincolor + ".png";

  return imgURL;
}

var isAvatarLocalStorageSet = function (){
  var gender = localStorage.getItem("myavatar-gender");
  var hairstyle = localStorage.getItem("myavatar-hairstyle");
  var haircolor = localStorage.getItem("myavatar-haircolor");
  var skincolor = localStorage.getItem("myavatar-skincolor");
  var allAttrSet = true;

  if(gender === null ||
    hairstyle === null ||
    haircolor === null ||
    skincolor === null) {
      allAttrSet = false;
  }

  return allAttrSet;
}

// Return element index in an array
var arrayElementIndex = function(element, array){
  for(var i=0; i<array.length; i++){
    if(element === array[i]){
      return i;
    }
  }
}

//
// Debugger
//
var currentState = function(){
  console.log(localStorage.getItem("myavatar-gender"));
  console.log(localStorage.getItem("myavatar-hairstyle"));
  console.log(localStorage.getItem("myavatar-haircolor"));
  console.log(localStorage.getItem("myavatar-skincolor"));
}