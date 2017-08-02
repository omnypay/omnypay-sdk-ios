(function () {
      
  var cssFragment = document.createDocumentFragment();
  var jsFragment = document.createDocumentFragment();

  var cssFiles = ['swiper', 
                  'bootstrap.min', 
                  'jqueryUi', 
                  'responsive', 
                  'style', 
                  'general', 
                  'https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min'];

  var jsFiles = [ 'bootstrap.min', 
                  'jquery-ui', 
                  'jquery.blockui', 
                  'swiper.min', 
                  'mustache'];

  var metaTag = document.createElement("meta");
  metaTag.setAttribute('charset','utf-8');
  cssFragment.appendChild(metaTag);  

  metaTag = document.createElement("meta");
  metaTag.setAttribute('http-equiv','X-UA-Compatible');
  metaTag.setAttribute('content', 'IE=edge');
  cssFragment.appendChild(metaTag);  

  metaTag = document.createElement("meta");
  metaTag.setAttribute('name','viewport');
  metaTag.setAttribute('content', 'width=device-width, initial-scale=1');
  cssFragment.appendChild(metaTag);  

  cssFiles.forEach(function(cssFile) {
    var linkTag  = document.createElement("link");
    linkTag.setAttribute("rel","stylesheet");
    linkTag.setAttribute("type","text/css");
    linkTag.setAttribute("href",cssFile + ".css");
    cssFragment.appendChild(linkTag);
  });

  var linkTag  = document.createElement("link");
    linkTag.setAttribute("rel","stylesheet");
    linkTag.setAttribute("href","https://fonts.googleapis.com/css?family=Open+Sans");
    cssFragment.appendChild(linkTag);

  jsFiles.forEach(function(jsFile) {
    var scriptTag  = document.createElement("script");
    scriptTag.setAttribute("type","text/javascript");
    scriptTag.setAttribute("src",jsFile + ".js");
    jsFragment.appendChild(scriptTag);
  });

  document.getElementsByTagName("head")[0].appendChild(cssFragment);
  var bodyTag = document.getElementsByTagName("body")[0];
  bodyTag.appendChild(jsFragment);
  bodyTag.insertAdjacentHTML( 'beforeend', '<div id="newPageLoader" style="display:none"> <img src="loader.svg" /> </div>' );
  setTimeout(function() { initialLoad(); }, 600);
})();

var ib_products;
var ib_userProfile;
var ib_paymentSummary;
var ib_stores;
var ib_error;
var ib_config;
var ib_receipt;
var loyaltySelected = true;
var firstTimeLoading = true;
var swiper;
var jsonData;
var colorMap = {};
var ib_buyNow = {"size":null, "sku":null, "color":null, "price": 0, "name": null};
var img_src = new Array();
var sizeArr = new Array();
var sizeArrSku = {};
var colorArr = new Array();
var colorArrSku = {};
var pageIsDisplayed = false;
var sizeDisplay;
var shippingDisplay;

function getBuyNow() {
  return JSON.stringify(ib_buyNow)
}

function getPaymentSummary() {
  return JSON.stringify(ib_paymentSummary)
}

function changeLoyaltySelection() {
  loyaltySelected = !loyaltySelected;
  if (loyaltySelected) {
    //apply all loyalty points
    $("#loyaltySelectionDiv i").attr("style", "")
    $.blockUI({ message: $('#newPageLoader'), css: {backgroundColor: "", border: "0px"} })
//    window.location = "zapbuyurl://applyLoyalty"
    window.webkit.messageHandlers.applyLoyalty.postMessage("");
  } else {
    //redeem 0 points
    $("#loyaltySelectionDiv i").attr("style", "color: lightgray")
    $.blockUI({ message: $('#newPageLoader'), css: {backgroundColor: "", border: "0px"} })
//    window.location = "zapbuyurl://removeLoyalty"
    window.webkit.messageHandlers.removeLoyalty.postMessage("");
  }
}

function setUpdatedStores() {
  displayTemplateInfo('#store_display', '#address-template', {"storeAddress12": ib_stores}, setUpdatedStoresCallback);
}

function setUpdatedStoresCallback() {
  var firstStoreItem = document.getElementById("store_display").firstElementChild;
  firstStoreItem.className = "item active";
  checkIfNoStoresAvailable();
}

function setUpdatedPaymentSummary() {
  displayTemplateInfo('#paymentInfoDiv', '#paymentInfo-template', getDisplayableDataForPaymentInfo(), setUpdatedPaymentSummaryCallback);
}

function setUpdatedPaymentSummaryCallback() {
  $("#price").html("$" + (parseInt(ib_paymentSummary.value)/100).toFixed(2));
  $.unblockUI();
}

function getDisplayableDataForPaymentInfo(){
  var displayableDataForPaymentInfo = {}; 
  displayableDataForPaymentInfo.cashRewards= "$" + (parseInt(ib_paymentSummary.cashRewards)/100).toFixed(2);
  displayableDataForPaymentInfo.subtotal= "($" + (parseInt(ib_paymentSummary.subtotal)/100).toFixed(2) + ")";
  displayableDataForPaymentInfo.promo= "($" + (parseInt(ib_paymentSummary.promo)/100).toFixed(2) + ")";
  displayableDataForPaymentInfo.totalSavings= "$" + (parseInt(ib_paymentSummary.totalSavings)/100).toFixed(2);
  displayableDataForPaymentInfo.payable= "$" + (parseInt(ib_paymentSummary.payable)/100).toFixed(2);
  displayableDataForPaymentInfo.tax= "$" + (parseInt(ib_paymentSummary.tax)/100).toFixed(2);
  return displayableDataForPaymentInfo;
}

function setShopperDetails() {
  displayTemplateInfo('#shopperAddressDiv', '#shopperAddress-template', getShopperDetails());
}

function getShopperDetails() {
  var shopperDetails = {};
  shopperDetails.shopperFullName = ib_userProfile.fullName;
  shopperDetails.shopperShippingAddress = ib_userProfile.shippingAddress;
  shopperDetails.shopperDeliveryDate = getDateByAddingDays(3);
  return shopperDetails;
}

function setProductDetails(productName, productPrice) {
  productInfo = {};
  productInfo.productTitle = $('<div/>').html(productName).text();
  productInfo.productOriginalPrice = "$"+(parseInt(productPrice)/100).toFixed(2);
  productInfo.productSalePrice = "$" + (parseInt(ib_paymentSummary.value)/100).toFixed(2);
  displayTemplateInfo('#productDescriptionDiv', '#productDescription-template', productInfo);
}

function displayTemplateInfo(displayInDiv, templateName, detailsObj, callbackFunction) {
  $(displayInDiv).load('templates.mst', function () {
    var template = $(templateName).html();
    Mustache.parse(template);
    var renderedTemplateInfo;
    if (detailsObj != null) {
      renderedTemplateInfo = Mustache.render(template, detailsObj);
    } else {
      renderedTemplateInfo = Mustache.render(template);
    }
    $(displayInDiv).html(renderedTemplateInfo);
    if(callbackFunction != null) {
      callbackFunction();
    }
    if (!pageIsDisplayed) {
      if (displayInDiv != "#errorDiv") {
        $('#buyNowDiv').show();
      } else {
        $('#buyNowDiv').hide();
      }
      $('#mainContentDiv').show();
      $.unblockUI();
      pageIsDisplayed = true;
    } 
    
  });
}

function getDateByAddingDays(daysToAdd) {
  var month_names = new Array("January", "February", "March",
   "April", "May", "June", "July", "August", "September",
   "October", "November", "December");

  var currentDate = new Date();
  currentDate.setDate(currentDate.getDate() + parseInt(daysToAdd))
  var currentMonth = currentDate.getMonth();
  var deliveryDay = currentDate.getDate();
  var deliveryDate = ((''+deliveryDay).length<2 ? '0' : '') + deliveryDay + ' ' +
     month_names[currentMonth] + ' ' + currentDate.getFullYear();
  return deliveryDate;
}

function setFooterDescription() {
  displayTemplateInfo('#cardDescriptionDiv', '#cardDescription-template', getFooterInfo());
}

function getFooterInfo() {
  var footerInfo = {};
  footerInfo.footerCardAlias = ib_paymentSummary.cardAlias + " " + ib_paymentSummary.cardNumber;
  footerInfo.footerRewardAlias = isKohlsMerchant ? "YES2YOU REWARDS 1234567890" : "COOL REWARDS 1234567890";
  return footerInfo;
}

function setPromoCashDetails() {
  displayTemplateInfo('#cashPromoDiv', '#cashPromo-template', getPromoCashInfo());
}

function getPromoCashInfo() {
  var promoCashInfo = {};
  promoCashInfo.promoCashImage = isKohlsMerchant ? "xs-icon2.jpg" : "coolcash.png";
  promoCashInfo.promoCashAmout = "$"+(parseInt(ib_paymentSummary.cashRewards)/100).toFixed(2);
  promoCashInfo.promoCashDescription = isKohlsMerchant ? "Kohl's cash" : "Cool cash";
  promoCashInfo.promoCashDate = "05/01/2017";
  return promoCashInfo;
}

function initialLoad() {
  $.blockUI({ message: $('#newPageLoader'), css: {backgroundColor: "", border: "0px"} });           
}
    
function populateProductDetails() {
  
  isKohlsMerchant = ib_config.merchantName.toUpperCase().includes("KOHL");
  
  if (ib_config.css != null && ib_config.css != "") {
    loadCssForClient(ib_config.css);
  }  

  performFlow = getFlowToUse();

  if (performFlow == 1) {
    // if there is only product then hide color and size selections
    $('#productColorSelectionDiv').hide();
    $('#productSizeSelectionDiv').hide();
    img_src.push(ib_products[0]["image-url"]);
    ib_buyNow.sku = ib_products[0].sku;
    ib_buyNow.name = ib_products[0].name;
    ib_buyNow.price = ib_products[0].price;
    setProductDetails(ib_buyNow.name, ib_buyNow.price);
  } else if (performFlow == 2) {
    // if only sizes are available; hide color selection and logic based on size selection only
    $.each(ib_products, function(index2, item){
      sizeArr.push({"size":item["product-features"]["size"]});
      sizeArrSku["size"+item["product-features"]["size"]] = item["sku"];
      if($.inArray(item["image-url"], img_src) < 0){
        img_src.push(item["image-url"]);
      }
    });
    loadSizes();
    $('#productColorSelectionDiv').hide();
  } else if (performFlow == 3) {
    // if only colors are available; hide size selection and logic based on color selection only
    $.each(ib_products, function(index2, item){
      colorArr.push({"color":item["product-features"]["color"],
          "swatchURL":item["swatch-image-url"],
          "backgroundColor":function(){
            if(this.swatchURL) {
              return "none";
            } else {
              return this.color;
            }
          },
          "display":function(){
            if(this.swatchURL) {
              return "block";
            } else {
              return "none";
            }
          }
      });
      colorArrSku["color"+item["product-features"]["color"]] = item["sku"];
      if($.inArray(item["image-url"], img_src) < 0){
        img_src.push(item["image-url"]);
      }
    });
    
    loadOnlyColors(colorArr);

    $('#productSizeSelectionDiv').hide();
  } else {
    // if both color and sizes are available
    $.each(ib_products, function(index2, item){
      if($.inArray(item["image-url"], img_src) < 0){
        img_src.push(item["image-url"]);
      }
      if($.inArray(item["product-features"]["size"],sizeArr) == -1)
        sizeArr.push(item["product-features"]["size"]);
      if($.inArray(item["product-features"]["color"], colorArr.map(function(a){return a.color})) == -1) {
        colorArr.push({"color":item["product-features"]["color"],
          "swatchURL":item["swatch-image-url"],
          "backgroundColor":function(){
            if(this.swatchURL) {
              return "none";
            } else {
              return this.color;
            }
          },
          "display":function(){
            if(this.swatchURL) {
              return "block";
            } else {
              return "none";
            }
          }
        });
      }
      if(item["product-features"]["color"] in colorMap) {
        colorMap[item["product-features"]["color"]]["sizes"].push({"size":item["product-features"]["size"], "sku": item["sku"], "price": item["price"], "name":item["name"]});
      } else {
        colorMap[item["product-features"]["color"]] = {};
        colorMap[item["product-features"]["color"]]["sizes"] = new Array();
        colorMap[item["product-features"]["color"]]["sizes"].push({"size":item["product-features"]["size"], "sku": item["sku"], "price": item["price"], "name":item["name"]});
        colorMap[item["product-features"]["color"]]["price"] = item["price"];
        colorMap[item["product-features"]["color"]]["name"] = item["name"];
        colorMap[item["product-features"]["color"]]["swatch-image-url"] = item["swatch-image-url"];
      }
    });
  
    loadColors(colorArr);
    
    $(".selectpicker .dropdown-menu li a").click(function(){
      $(".selectpicker .btn span").text($(this).text());
      $(".selectpicker .btn span").val($(this).text());
    });
  }

  initializeCarousel();
 
  // set payable and taxes and regular price
  setUpdatedPaymentSummary();
 
  // set promo cash as per client
  setPromoCashDetails();
  
  // Load card description
  setFooterDescription();

  // Load shipping div
  setupShippingView();

  $.unblockUI();
}

function loadOnlyColorsCallback() {
  $('input[type=radio][name=options]').change(function() {
    var color = this.value;
    loadColor(color);
    ib_buyNow.sku = colorArrSku["color"+color];
    var product = ib_products.filter(function(ele) {return ele.sku == ib_buyNow.sku})[0];
    ib_buyNow.name = product.name;
    ib_buyNow.price = product.price;
    setProductDetails(ib_buyNow.name, ib_buyNow.price);
    checkforFirstTimePageLoading();
  });
    
  triggerFirstItem();
}

function loadColorsAndSizesCallback() {
  $('input[type=radio][name=options]').change(function() {
    var color = this.value;
    ib_buyNow.color = color;
    ib_buyNow.sku = null;
    sizeArr = colorMap[color]["sizes"];
    loadSizes();
    loadColor(color);
  });
  
  triggerFirstItem();
}

function triggerFirstItem() {
  $('input:radio[name="options"]').filter("[value='"+colorArr[0]["color"]+"']").prop("checked",true);
  $('input:radio[name="options"]').filter("[value='"+colorArr[0]["color"]+"']").parent().addClass('active');
  $('input:radio[name="options"]').filter("[value='"+colorArr[0]["color"]+"']").trigger("change");
}

function getFlowToUse() {
  /*
    1 - only 1 product
    2 - only sizes available
    3 - only colors available
    4 - both sizes and colors available
  */
  if (ib_products.length == 1) {
    return 1;
  } else if (ib_products[0]["product-features"]["color"] == null || ib_products[0]["product-features"]["color"] == "") {
    return 2;
  } else if (ib_products[0]["product-features"]["size"] == null || ib_products[0]["product-features"]["size"] == "") {
    return 3;
  } else {
    return 4;
  }
}

function loadCssForClient(cssFileName) {
  var lnk = document.createElement('link');
  lnk.type= 'text/css';
  lnk.href= cssFileName;
  lnk.rel= 'stylesheet';
  document.getElementsByTagName('head')[0].appendChild(lnk);
}

function checkIfNoStoresAvailable() {
  if (ib_stores[0].name == "Not available at store") {
   $('#available-at-store').hide();
 } else {
   $('#available-at-store').show();
 }

 if (ib_stores.length == 1) {
    $("#left-carousel-arrow").hide();
    $("#right-carousel-arrow").hide();
  } else {
    $("#left-carousel-arrow").show();
    $("#right-carousel-arrow").show();
  }
}

function setSelectedSize(selSize){
  if (sizeDisplay == "dropdown") {
    $('#selected_size').html(selSize);  
  } else if (sizeDisplay == "single") {
    $('.singleSizeSelection').removeClass("active");
    $('.singleSizeSelection[data-id="' + selSize + '"]').addClass("active");
  } else if (sizeDisplay == "radio") {
    $('.sizeSelectionRadioLabel input[name=sizeSelectionRadioButton][value="' + selSize + '"]').prop("checked", "true");
  } 
  
  ib_buyNow.size = selSize;
  if (performFlow == 4) {
    const sizeSkuArr = colorMap[ib_buyNow.color]["sizes"];
  
    $.each(sizeSkuArr, function(skuIndex, item){
      if(item.size == selSize){
        ib_buyNow.sku = item.sku;
        ib_buyNow.name = item.name;
        ib_buyNow.price = item.price;
        setProductDetails(ib_buyNow.name, ib_buyNow.price);
        return false;
      }
    });
  } else if (performFlow == 2) {
    // only sizes are available
    ib_buyNow.sku = sizeArrSku["size"+selSize];
    var product = ib_products.filter(function(ele) {return ele.sku == ib_buyNow.sku})[0];
    ib_buyNow.name = product.name;
    ib_buyNow.price = product.price;
    setProductDetails(ib_buyNow.name, ib_buyNow.price);
  }
  checkforFirstTimePageLoading();
}

function loadSizes() {
  sizeDisplay = $('#productSizeSelectionDiv').data('display-type');
  if ( sizeDisplay == null || sizeDisplay == "") {
    if (sizeArr.length < 6 ) {
      sizeDisplay = "single";  
    } else {
      sizeDisplay = "dropdown"
    }
  }
  if ( sizeDisplay == "dropdown" ) {
    displayTemplateInfo('#productSizeSelectionDiv', '#size-dropdown-template', {"sizeArr": sizeArr}, loadSizesCallback);  
  } else if (sizeDisplay == "single") {
    displayTemplateInfo('#productSizeSelectionDiv', '#size-single-template', {"sizeArr": sizeArr}, loadSizesCallback);      
  } else if (sizeDisplay == "radio") {
    displayTemplateInfo('#productSizeSelectionDiv', '#size-radio-template', {"sizeArr": sizeArr}, loadSizesCallback);      
  }
}

function loadSizesCallback() {
  setSelectedSize(sizeArr[0].size);
}

function loadColors(colorArray) {
  displayTemplateInfo('#productColorSelectionDiv', '#completeColor-template', {"color": "x", "colorArr": colorArray},loadColorsAndSizesCallback);
}

function loadOnlyColors(colorArray) {
  displayTemplateInfo('#productColorSelectionDiv', '#completeColor-template', {"color": "x", "colorArr": colorArray},loadOnlyColorsCallback);
}

function loadColor(color) {
  $('#colortext').html(color);
}

function buyNowAction(){
  if(ib_buyNow.sku){
//    window.open("thankyou.html");
    window.webkit.messageHandlers.showReceipt.postMessage(ib_buyNow);
  } else {
    $("<div title='Alert!'>Please select size to continue</div>").dialog({ width:250,height: 100,resizable: false, draggable:false, modal: true})
  }
}

function initializeCarousel() {
  displayTemplateInfo('#productImagesDiv', '#swiper-template', {"img_src": img_src}, initializeCarouselCallback);
}

function initializeCarouselCallback() {
  swiper =  new Swiper('.swiper-container', {
    pagination: '.swiper-pagination',
    paginationClickable: true
  });
}

function checkforFirstTimePageLoading() {
  if (firstTimeLoading) {
    firstTimeLoading = false;
  } else {
    $.blockUI({ message: $('#newPageLoader'), css: {backgroundColor: "", border: "0px"} });
//    window.location = "zapbuyurl://sku/" + ib_buyNow.sku;
    window.webkit.messageHandlers.skuChanged.postMessage(ib_buyNow);
  }
}

function setupShippingView() {
  var shippingDisplay = $('#shippingDiv').data('display-type');
  if (shippingDisplay == "onlyShipping") {
    displayTemplateInfo('#shippingDiv', '#singleShipping-template', {"shippingHeading": "Free Shipping"}, setupOnlyShippingCallback);  
  } else if (shippingDisplay == "onlyPickup") {
    displayTemplateInfo('#shippingDiv', '#singleShipping-template', {"shippingHeading": "Free Pickup"}, setupOnlyPickupInitialCallback);  
  } else {
    displayTemplateInfo('#shippingDiv', '#shipping-template', null, setupShippingViewCallback);  
  }  
}

function setupOnlyShippingCallback() {
  displayTemplateInfo('#singleShippingAddr', '#shopperAddress-template', getShopperDetails());
}

function setupOnlyPickupCallback() {
  displayTemplateInfo('#store_display', '#address-template', {"storeAddress12": ib_stores}, setUpdatedStoresCallback);
}

function setupOnlyPickupInitialCallback() {
  displayTemplateInfo('#singleShippingAddr', '#onlyPickup-template', {"storeAddress12": ib_stores}, setupOnlyPickupCallback);
}

function setupShippingViewCallback() {
  // set shopper details
  setShopperDetails();
  // Load store details
  setUpdatedStores();
}

function displayErrorDiv() {
  displayTemplateInfo('#errorDiv', '#error-template', {"errorMsg" : ib_error.message}, displayErrorDivCallback);
}

function displayErrorDivCallback() {
  $.unblockUI();
  $("#buyNowDiv").hide();
}
    

/* Receipt Page Functions and Variables */

function setValues() {
  
  if (ib_config != null && ib_config.css != null && ib_config.css != "") {
    loadCssForClient(ib_config.css);
  }

  displayThankyouSection();

  setReceiptHeaderDetails();

  setReceiptCardDetails();

  setReceiptPagePaymentDetails();  
}

function setReceiptPagePaymentDetails() {
  displayTemplateInfo('#receiptPaymentInfoDiv', '#paymentInfo-template', getReceiptPaymentDetails());
}

function getReceiptPaymentDetails() {
  var paymentInfo = {};
  paymentInfo.subtotal = "$" + (parseInt(ib_receipt["subtotal"])/100.0).toFixed(2);
  paymentInfo.cashRewards = "($" + (parseInt(ib_receipt["cashRewards"])/100.0).toFixed(2) + ")";
  paymentInfo.promo = "($" + (parseInt(ib_receipt["promo"])/100.0).toFixed(2) + ")";
  paymentInfo.tax = "$" + (parseInt(ib_receipt["tax"])/100.0).toFixed(2);
  paymentInfo.payable = "$" + (parseInt(ib_receipt["payable"])/100.0).toFixed(2);
  paymentInfo.totalSavings = "$" + (parseInt(ib_receipt["totalSavings"])/100.0).toFixed(2);
  return paymentInfo;      
}
  
function setReceiptHeaderDetails() {
  displayTemplateInfo('#receiptDetailsDiv', '#receiptHeader-template', getReceiptHeaderData());
}

function getReceiptHeaderData() {
  var receiptHeaderInfo = {};
  var ltrimmedReceiptId = ib_receipt["receiptId"];
  receiptHeaderInfo.receiptId = ltrimmedReceiptId.slice(-8);
  receiptHeaderInfo.receiptDateTime = getCompleteCurrentDateAndTime();
  receiptHeaderInfo.productName = $('<div/>').html(ib_receipt["productName"]).text();
  return receiptHeaderInfo;
}

function getCompleteCurrentDateAndTime() {
  var month_names = new Array("January", "February", "March",
                              "April", "May", "June", "July", "August", "September",
                              "October", "November", "December");
  var currentDate = new Date();
  var currentMonth = currentDate.getMonth();
  var currentDay = currentDate.getDate();
  var currentHour = currentDate.getHours();
  var displayHours = currentHour >= 12 ? currentHour-12 : currentHour;
  var currentMinutes = currentDate.getMinutes();
  var receiptDate = month_names[currentMonth] + ' ' + ((''+currentDay).length<2 ? '0' : '') + currentDay + ', '
  + currentDate.getFullYear() + ', ' + ((''+displayHours).length<2 ? '0' : '') + displayHours
  + ':' + ((''+currentMinutes).length<2 ? '0' : '') + currentMinutes + ' ' + (currentHour>=12?'pm':'am');
  return receiptDate;
}

function displayThankyouSection() {
  displayTemplateInfo('#thankYouDiv', '#thankYou-template');
}

function setReceiptCardDetails() {
  displayTemplateInfo('#receiptCardDetailsDiv', '#cardDetails-template', getCardDetailsForReceipt());
}

function getCardDetailsForReceipt() {
  var cardInfo = {};
  cardInfo.cardName = ib_receipt["cardName"];
  cardInfo.cardNumber = ib_receipt["cardNumber"];
  cardInfo.finalAmount = "$" + (parseInt(ib_receipt["finalAmount"])/100.0).toFixed(2);
  return cardInfo;
}
