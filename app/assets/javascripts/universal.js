var universal;
universal = function() {

    /* ---------------------------------------------- /*
        Initialize
    /* ---------------------------------------------- */

    var overlayMenu = $('#overlay-menu'),
        navbar = $('.navbar-custom');


    /* ---------------------------------------------- /*
        Make Table rows clickable
    /* ---------------------------------------------- */

    $("div.location").click(function() {
      window.location = $(this).data("link")
    })

    /* ---------------------------------------------- /*
        Animated scrolling / Scroll Up
    /* ---------------------------------------------- */

    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $('.scroll-up').fadeIn();
        } else {
            $('.scroll-up').fadeOut();
        }
    });

    /* ---------------------------------------------- /*
        Show/Hide  Swapsea Logo Navbar
    /* ---------------------------------------------- */

    $("button.show-sidebar").click(function(){

        $("#swapsea-nav-logo").toggleClass('transparent');

    });

    /* ---------------------------------------------- /*
        Show/Hide overlay menu
    /* ---------------------------------------------- */

    $('#toggle-menu').on('click', function() {
        showMenu();
        $('body').addClass('aux-navigation-active');
        return false;
    });

    $('#overlay-menu-hide').on('click', function() {
        hideMenu();
        $('body').removeClass('aux-navigation-active');
        return false;
    });

    $(window).keydown(function(e) {
        if (overlayMenu.hasClass('active')) {
            if (e.which === 27) {
                hideMenu();
            }
        }
    });

    function showMenu() {


        overlayMenu.addClass('active');
    }

    function hideMenu() {


        overlayMenu.removeClass('active');
    }


    /* ---------------------------------------------- /*
     * Overlay dropdown menu
    /* ---------------------------------------------- */

    $('#nav > li.slidedown > a').on('click', function() {
        if ($(this).attr('class') != 'active') {
            $('#nav li ul').slideUp({
                duration: 300,
                easing: 'swing'
            });
            $('#nav li a').removeClass('active');
            $(this).next().slideToggle({
                duration: 300,
                easing: 'swing'
            }).addClass('open');
            $(this).addClass('active');
        } else {
            $('#nav li ul').slideUp({
                duration: 300,
                easing: 'swing'
            }).removeClass('open');
            $(this).removeClass('active');
        }
        return false;
    });

    /* ----------------------------------------------
        SWITCHERY
    ---------------------------------------------- */

    var green = "#00acac", red = "#ff5b57", blue = "#348fe2", purple = "#727cb6", orange = "#ff6600", black = "#2d353c";
    var renderSwitcher = function() {
        if ($("[data-render=switchery]").length !== 0) {
            $("[data-render=switchery]").each(function() {
                var e = green;
                if ($(this).attr("data-theme")) {
                    switch ($(this).attr("data-theme")) {
                    case"red":
                        e = red;
                        break;
                    case"blue":
                        e = blue;
                        break;
                    case"purple":
                        e = purple;
                        break;
                    case"orange":
                        e = orange;
                        break;
                    case"black":
                        e = black;
                        break
                    }
                }
                var t = {};
                t.color = e;
                t.secondaryColor = $(this).attr("data-secondary-color") ? $(this).attr("data-secondary-color") : "#dfdfdf";
                t.className = $(this).attr("data-classname") ? $(this).attr("data-classname") : "switchery";
                t.disabled = $(this).attr("data-disabled") ? true : false;
                t.disabledOpacity = $(this).attr("data-disabled-opacity") ? $(this).attr("data-disabled-opacity") : .5;
                t.speed = $(this).attr("data-speed") ? $(this).attr("data-speed") : "0.5s";
                var n = new Switchery(this, t)
            })
        }
    };
    var checkSwitcherState = function() {
        $('[data-click="check-switch"]').on("click", function() {
            if ($(this).prop("checked")) {
                $(this).prop( "checked", false );
            }
            else {
                $(this).prop( "checked", true );
            }
        });
    };
    var renderPowerRangeSlider = function() {
        if ($('[data-render="powerange-slider"]').length !== 0) {
            $('[data-render="powerange-slider"]').each(function() {
                var e = {};
                e.decimal = $(this).attr("data-decimal") ? $(this).attr("data-decimal") : false;
                e.disable = $(this).attr("data-disable") ? $(this).attr("data-disable") : false;
                e.disableOpacity = $(this).attr("data-disable-opacity") ? $(this).attr("data-disable-opacity") : .5;
                e.hideRange = $(this).attr("data-hide-range") ? $(this).attr("data-hide-range") : false;
                e.klass = $(this).attr("data-class") ? $(this).attr("data-class") : "";
                e.min = $(this).attr("data-min") ? $(this).attr("data-min") : 0;
                e.max = $(this).attr("data-max") ? $(this).attr("data-max") : 100;
                e.start = $(this).attr("data-start") ? $(this).attr("data-start") : null;
                e.step = $(this).attr("data-step") ? $(this).attr("data-step") : null;
                e.vertical = $(this).attr("data-vertical") ? $(this).attr("data-vertical") : false;
                if ($(this).attr("data-height")) {
                    $(this).closest(".slider-wrapper").height($(this).attr("data-height"))
                }
                var t = new Switchery(this, e);
                var n = new Powerange(this, e)
            })
        }
    };
    var FormSliderSwitcher = function() {
        "use strict";
        return {
            init: function() {
                renderSwitcher();
                checkSwitcherState();
                renderPowerRangeSlider()
            }
        }
    }()

    FormSliderSwitcher.init();
}

$(document).ready(universal);
$(document).on('page:load', universal);
