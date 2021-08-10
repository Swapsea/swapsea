
var admin;
admin = function() {

    var handleSlimScroll = function() {
        "use strict";
        $("[data-scrollbar=true]").each(function() {
            generateSlimScroll($(this))
        })
    };
    var generateSlimScroll = function(e) {
        var t = $(e).attr("data-height");
        t=!t ? $(e).height() : t;
        var n = {
            height: t,
            alwaysVisible: true
        };
        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            n.wheelStep = 3;
            n.touchScrollStep = 100
        }
        $(e).slimScroll(n)
    };

    var handleSidebarMenu = function() {
        "use strict";
        $(".sidebar .nav > .has-sub > a").click(function() {
            var e = $(this).next(".sub-menu");
            var t = ".sidebar .nav > li.has-sub > .sub-menu";
            if ($(".page-sidebar-minified").length === 0) {
                $(t).not(e).slideUp(250, function() {
                    $(this).closest("li").removeClass("expand")
                });
                $(e).slideToggle(250, function() {
                    var e = $(this).closest("li");
                    if ($(e).hasClass("expand")) {
                        $(e).removeClass("expand")
                    } else {
                        $(e).addClass("expand")
                    }
                })
            }
        });
        $(".sidebar .nav > .has-sub .sub-menu li.has-sub > a").click(function() {
            if ($(".page-sidebar-minified").length === 0) {
                var e = $(this).next(".sub-menu");
                $(e).slideToggle(250)
            }
        })
    };
    var handleMobileSidebarToggle = function() {
        var e = false;
        $(".sidebar").on("click touchstart", function(t) {
            if ($(t.target).closest(".sidebar").length !== 0) {
                e = true
            } else {
                e = false;
                t.stopPropagation()
            }
        });
        $(document).on("click touchstart", function(t) {
            if ($(t.target).closest(".sidebar").length === 0) {
                e = false
            }
            if (!t.isPropagationStopped() && e !== true) {
                if ($("#page-container").hasClass("page-sidebar-toggled")) {
                    $("#page-container").removeClass("page-sidebar-toggled")
                }
                if ($(window).width() < 979) {
                    if ($("#page-container").hasClass("page-with-two-sidebar")) {
                        $("#page-container").removeClass("page-right-sidebar-toggled")
                    }
                }
            }
        });
        $("[data-click=right-sidebar-toggled]").click(function(e) {
            e.stopPropagation();
            var t = "#page-container";
            var n = "page-right-sidebar-collapsed";
            n = $(window).width() < 979 ? "page-right-sidebar-toggled" : n;
            if ($(t).hasClass(n)) {
                $(t).removeClass(n)
            } else {
                $(t).addClass(n)
            }
            if ($(window).width() < 480) {
                $("#page-container").removeClass("page-sidebar-toggled")
            }
        });
        $("[data-click=sidebar-toggled]").click(function(e) {
            e.stopPropagation();
            var t = "page-sidebar-toggled";
            var n = "#page-container";
            if ($(n).hasClass(t)) {
                $(n).removeClass(t)
            } else {
                $(n).addClass(t)
            }
            if ($(window).width() < 480) {
                $("#page-container").removeClass("page-right-sidebar-toggled")
            }
        })
    };
    var handleSidebarMinify = function() {
        $("[data-click=sidebar-minify]").click(function(e) {
            e.preventDefault();
            var t = "page-sidebar-minified";
            var n = "#page-container";
            if ($(n).hasClass(t)) {
                $(n).removeClass(t);
                if ($(n).hasClass("page-sidebar-fixed")) {
                    generateSlimScroll($('#sidebar [data-scrollbar="true"]'))
                }
            } else {
                $(n).addClass(t);
                if ($(n).hasClass("page-sidebar-fixed")) {
                    $('#sidebar [data-scrollbar="true"]').slimScroll({
                        destroy: true
                    });
                    $('#sidebar [data-scrollbar="true"]').removeAttr("style")
                }
                $("#sidebar [data-scrollbar=true]").trigger("mouseover")
            }
            $(window).trigger("resize")
        })
    };
    var handlePageContentView = function() {
        "use strict";
        $.when($("#page-loader").addClass("hide")).done(function() {
            $("#page-container").addClass("in")
        })
    };
    var handlePanelAction = function() {
        "use strict";
        $("[data-click=panel-remove]").hover(function() {
            $(this).tooltip({
                title: "Remove",
                placement: "bottom",
                trigger: "hover",
                container: "body"
            });
            $(this).tooltip("show")
        });
        $("[data-click=panel-remove]").click(function(e) {
            e.preventDefault();
            $(this).tooltip("destroy");
            $(this).closest(".panel").remove()
        });
        $("[data-click=panel-collapse]").hover(function() {
            $(this).tooltip({
                title: "Collapse / Expand",
                placement: "bottom",
                trigger: "hover",
                container: "body"
            });
            $(this).tooltip("show")
        });
        $("[data-click=panel-collapse]").click(function(e) {
            e.preventDefault();
            $(this).closest(".panel").find(".panel-body").slideToggle()
        });
        $("[data-click=panel-reload]").hover(function() {
            $(this).tooltip({
                title: "Reload",
                placement: "bottom",
                trigger: "hover",
                container: "body"
            });
            $(this).tooltip("show")
        });
        $("[data-click=panel-reload]").click(function(e) {
            e.preventDefault();
            var t = $(this).closest(".panel");
            if (!$(t).hasClass("panel-loading")) {
                var n = $(t).find(".panel-body");
                var r = '<div class="panel-loader"><span class="spinner-small"></span></div>';
                $(t).addClass("panel-loading");
                $(n).prepend(r);
                setTimeout(function() {
                    $(t).removeClass("panel-loading");
                    $(t).find(".panel-loader").remove()
                }, 2e3)
            }
        });
        $("[data-click=panel-expand]").hover(function() {
            $(this).tooltip({
                title: "Expand / Compress",
                placement: "bottom",
                trigger: "hover",
                container: "body"
            });
            $(this).tooltip("show")
        });
        $("[data-click=panel-expand]").click(function(e) {
            e.preventDefault();
            var t = $(this).closest(".panel");
            var n = $(t).find(".panel-body");
            var r = 40;
            if ($(n).length !== 0) {
                var i = $(t).offset().top;
                var s = $(n).offset().top;
                r = s - i
            }
            if ($("body").hasClass("panel-expand") && $(t).hasClass("panel-expand")) {
                $("body, .panel").removeClass("panel-expand");
                $(".panel").removeAttr("style");
                $(n).removeAttr("style")
            } else {
                $("body").addClass("panel-expand");
                $(this).closest(".panel").addClass("panel-expand");
                if ($(n).length !== 0 && r != 40) {
                    var o = 40;
                    $(t).find(" > *").each(function() {
                        var e = $(this).attr("class");
                        if (e != "panel-heading" && e != "panel-body") {
                            o += $(this).height() + 30
                        }
                    });
                    if (o != 40) {
                        $(n).css("top", o + "px")
                    }
                }
            }
            $(window).trigger("resize")
        })
    };
    var handleDraggablePanel = function() {
        "use strict";
        var e = $(".panel").parent("[class*=col]");
        var t = ".panel-heading";
        var n = ".row > [class*=col]";
        $(e).sortable({
            handle: t,
            connectWith: n,
            stop: function(e, t) {
                t.item.find(".panel-title").append('<i class="fa fa-refresh fa-spin m-l-5" data-id="title-spinner"></i>');
                handleSavePanelPosition(t.item)
            }
        })
    };
    var handelTooltipPopoverActivation = function() {
        "use strict";
        $("[data-toggle=tooltip]").tooltip();
        $("[data-toggle=popover]").popover()
    };
    var handleScrollToTopButton = function() {
        "use strict";
        $(document).scroll(function() {
            var e = $(document).scrollTop();
            if (e >= 200) {
                $("[data-click=scroll-top]").addClass("in")
            } else {
                $("[data-click=scroll-top]").removeClass("in")
            }
        });
        $("[data-click=scroll-top]").click(function(e) {
            e.preventDefault();
            $("html, body").animate({
                scrollTop: $("body").offset().top
            }, 500)
        })
    };
    var handleThemePageStructureControl = function() {
        if ($.cookie && $.cookie("theme")) {
            if ($(".theme-list").length !== 0) {
                $(".theme-list [data-theme]").closest("li").removeClass("active");
                $('.theme-list [data-theme="' + $.cookie("theme") + '"]').closest("li").addClass("active")
            }
            var e = "assets/css/theme/" + $.cookie("theme") + ".css";
            $("#theme").attr("href", e)
        }
        if ($.cookie && $.cookie("sidebar-styling")) {
            if ($(".sidebar").length !== 0 && $.cookie("sidebar-styling") == "grid") {
                $(".sidebar").addClass("sidebar-grid");
                $('[name=sidebar-styling] option[value="2"]').prop("selected", true)
            }
        }
        if ($.cookie && $.cookie("header-styling")) {
            if ($(".header").length !== 0 && $.cookie("header-styling") == "navbar-inverse") {
                $(".header").addClass("navbar-inverse");
                $('[name=header-styling] option[value="2"]').prop("selected", true)
            }
        }
        if ($.cookie && $.cookie("content-gradient")) {
            if ($("#page-container").length !== 0 && $.cookie("content-gradient") == "enabled") {
                $("#page-container").addClass("gradient-enabled");
                $('[name=content-gradient] option[value="2"]').prop("selected", true)
            }
        }
        if ($.cookie && $.cookie("content-styling")) {
            if ($("body").length !== 0 && $.cookie("content-styling") == "black") {
                $("body").addClass("flat-black");
                $('[name=content-styling] option[value="2"]').prop("selected", true)
            }
        }
        $(".theme-list [data-theme]").live("click", function() {
            var e = "assets/css/theme/" + $(this).attr("data-theme") + ".css";
            $("#theme").attr("href", e);
            $(".theme-list [data-theme]").not(this).closest("li").removeClass("active");
            $(this).closest("li").addClass("active");
            $.cookie("theme", $(this).attr("data-theme"))
        });
        $(".theme-panel [name=header-styling]").live("change", function() {
            var e = $(this).val() == 1 ? "navbar-default": "navbar-inverse";
            var t = $(this).val() == 1 ? "navbar-inverse": "navbar-default";
            $("#header").removeClass(t).addClass(e);
            $.cookie("header-styling", e)
        });
        $(".theme-panel [name=sidebar-styling]").live("change", function() {
            if ($(this).val() == 2) {
                $("#sidebar").addClass("sidebar-grid");
                $.cookie("sidebar-styling", "grid")
            } else {
                $("#sidebar").removeClass("sidebar-grid");
                $.cookie("sidebar-styling", "default")
            }
        });
        $(".theme-panel [name=content-gradient]").live("change", function() {
            if ($(this).val() == 2) {
                $("#page-container").addClass("gradient-enabled");
                $.cookie("content-gradient", "enabled")
            } else {
                $("#page-container").removeClass("gradient-enabled");
                $.cookie("content-gradient", "disabled")
            }
        });
        $(".theme-panel [name=content-styling]").live("change", function() {
            if ($(this).val() == 2) {
                $("body").addClass("flat-black");
                $.cookie("content-styling", "black")
            } else {
                $("body").removeClass("flat-black");
                $.cookie("content-styling", "default")
            }
        });
        $(".theme-panel [name=sidebar-fixed]").live("change", function() {
            if ($(this).val() == 1) {
                if ($(".theme-panel [name=header-fixed]").val() == 2) {
                    alert("Default Header with Fixed Sidebar option is not supported. Proceed with Fixed Header with Fixed Sidebar.");
                    $('.theme-panel [name=header-fixed] option[value="1"]').prop("selected", true);
                    $("#header").addClass("navbar-fixed-top");
                    $("#page-container").addClass("page-header-fixed")
                }
                $("#page-container").addClass("page-sidebar-fixed");
                if (!$("#page-container").hasClass("page-sidebar-minified")) {
                    generateSlimScroll($('.sidebar [data-scrollbar="true"]'))
                }
            } else {
                $("#page-container").removeClass("page-sidebar-fixed");
                if ($(".sidebar .slimScrollDiv").length !== 0) {
                    if ($(window).width() <= 979) {
                        $(".sidebar").each(function() {
                            if (!($("#page-container").hasClass("page-with-two-sidebar") && $(this).hasClass("sidebar-right"))) {
                                $(this).find(".slimScrollBar").remove();
                                $(this).find(".slimScrollRail").remove();
                                $(this).find('[data-scrollbar="true"]').removeAttr("style");
                                var e = $(this).find('[data-scrollbar="true"]').parent();
                                var t = $(e).html();
                                $(e).replaceWith(t)
                            }
                        })
                    } else if ($(window).width() > 979) {
                        $('.sidebar [data-scrollbar="true"]').slimScroll({
                            destroy: true
                        });
                        $('.sidebar [data-scrollbar="true"]').removeAttr("style")
                    }
                }
                if ($("#page-container .sidebar-bg").length === 0) {
                    $("#page-container").append('<div class="sidebar-bg"></div>')
                }
            }
        });
        $(".theme-panel [name=header-fixed]").live("change", function() {
            if ($(this).val() == 1) {
                $("#header").addClass("navbar-fixed-top");
                $("#page-container").addClass("page-header-fixed");
                $.cookie("header-fixed", true)
            } else {
                if ($(".theme-panel [name=sidebar-fixed]").val() == 1) {
                    alert("Default Header with Fixed Sidebar option is not supported. Proceed with Default Header with Default Sidebar.");
                    $('.theme-panel [name=sidebar-fixed] option[value="2"]').prop("selected", true);
                    $("#page-container").removeClass("page-sidebar-fixed");
                    if ($("#page-container .sidebar-bg").length === 0) {
                        $("#page-container").append('<div class="sidebar-bg"></div>')
                    }
                }
                $("#header").removeClass("navbar-fixed-top");
                $("#page-container").removeClass("page-header-fixed");
                $.cookie("header-fixed", false)
            }
        })
    };
    var handleThemePanelExpand = function() {
        $('[data-click="theme-panel-expand"]').live("click", function() {
            var e = ".theme-panel";
            var t = "active";
            if ($(e).hasClass(t)) {
                $(e).removeClass(t)
            } else {
                $(e).addClass(t)
            }
        })
    };
    var handleAfterPageLoadAddClass = function() {
        if ($("[data-pageload-addclass]").length !== 0) {
            $(window).load(function() {
                $("[data-pageload-addclass]").each(function() {
                    var e = $(this).attr("data-pageload-addclass");
                    $(this).addClass(e)
                })
            })
        }
    };
    var handleSavePanelPosition = function(e) {
        "use strict";
        if ($(".ui-sortable").length !== 0) {
            var t = [];
            var n = 0;
            $.when($(".ui-sortable").each(function() {
                var e = $(this).find("[data-sortable-id]");
                if (e.length !== 0) {
                    var r = [];
                    $(e).each(function() {
                        var e = $(this).attr("data-sortable-id");
                        r.push({
                            id: e
                        })
                    });
                    t.push(r)
                } else {
                    t.push([])
                }
                n++
            })).done(function() {
                var n = window.location.href;
                n = n.split("?");
                n = n[0];
                localStorage.setItem(n, JSON.stringify(t));
                $(e).find('[data-id="title-spinner"]').delay(500).fadeOut(500, function() {
                    $(this).remove()
                })
            })
        }
    };
    var handleLocalStorage = function() {
        "use strict";
        if (typeof Storage !== "undefined") {
            var e = window.location.href;
            e = e.split("?");
            e = e[0];
            var t = localStorage.getItem(e);
            if (t) {
                t = JSON.parse(t);
                var n = 0;
                $(".panel").parent('[class*="col-"]').each(function() {
                    var e = t[n];
                    var r = $(this);
                    $.each(e, function(e, t) {
                        var n = '[data-sortable-id="' + t.id + '"]';
                        if ($(n).length !== 0) {
                            var i = $(n).clone();
                            $(n).remove();
                            $(r).append(i)
                        }
                    });
                    n++
                })
            }
        } else {
            alert("Your browser is not supported with the local storage")
        }
    };
    var handleResetLocalStorage = function() {
        "use strict";
        $("[data-click=reset-local-storage]").live("click", function(e) {
            e.preventDefault();
            var t = "" + '<div class="modal fade" data-modal-id="reset-local-storage-confirmation">' + '    <div class="modal-dialog">' + '        <div class="modal-content">' + '            <div class="modal-header">' + '                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>' + '                <h4 class="modal-title"><i class="fa fa-refresh m-r-5"></i> Reset Local Storage Confirmation</h4>' + "            </div>" + '            <div class="modal-body">' + '                <div class="alert alert-info m-b-0">Would you like to RESET all your saved widgets and clear Local Storage?</div>' + "            </div>" + '            <div class="modal-footer">' + '                <a href="javascript:;" class="btn btn-sm btn-white" data-dismiss="modal"><i class="fa fa-close"></i> No</a>' + '                <a href="javascript:;" class="btn btn-sm btn-inverse" data-click="confirm-reset-local-storage"><i class="fa fa-check"></i> Yes</a>' + "            </div>" + "        </div>" + "    </div>" + "</div>";
            $("body").append(t);
            $('[data-modal-id="reset-local-storage-confirmation"]').modal("show")
        });
        $('[data-modal-id="reset-local-storage-confirmation"]').live("hidden.bs.modal", function() {
            $('[data-modal-id="reset-local-storage-confirmation"]').remove()
        });
        $("[data-click=confirm-reset-local-storage]").live("click", function(e) {
            e.preventDefault();
            var t = window.location.href;
            t = t.split("?");
            t = t[0];
            localStorage.removeItem(t);
            window.location.href = document.URL
        })
    };
    var App = function() {
        "use strict";
        return {
            init: function() {
                //handleDraggablePanel();
                //handleLocalStorage();
                //handleResetLocalStorage();
                handleSlimScroll();
                handleSidebarMenu();
                handleMobileSidebarToggle();
                handleSidebarMinify();
                //handleThemePageStructureControl();
                //handleThemePanelExpand();
                //handleAfterPageLoadAddClass();
                handlePanelAction();
                handelTooltipPopoverActivation();
                handleScrollToTopButton();
                handlePageContentView()
            }
        }
    }()

    var green = "#00acac", red = "#ff5b57", blue = "#348fe2", purple = "#727cb6", orange = "#f59c1a", black = "#2d353c";
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

    App.init();
    FormSliderSwitcher.init();

    // Enable Datepicker on all text elements with class 'datepicker'
    $('.datepicker').datepicker();

    function samePostalAddress() {

        if ($('#same_postal_address').prop('checked')) {

            $('#setting_business_address').prop( "placeholder", '' );
            $('#setting_business_suburb').prop( "placeholder", '' );
            $('#setting_business_state').prop( "placeholder", '' );
            $('#setting_business_postcode').prop( "placeholder", '' );

            $('#setting_business_postal_address').prop( "placeholder", '' );
            $('#setting_business_postal_suburb').prop( "placeholder", '' );
            $('#setting_business_postal_state').prop( "placeholder", '' );
            $('#setting_business_postal_postcode').prop( "placeholder", '' );

            $('#setting_business_postal_address').val($('#setting_business_address').val());
            $('#setting_business_postal_suburb').val($('#setting_business_suburb').val());
            $('#setting_business_postal_state').val($('#setting_business_state').val());
            $('#setting_business_postal_postcode').val($('#setting_business_postcode').val());

            $('#setting_business_postal_address').prop( "disabled", true );
            $('#setting_business_postal_suburb').prop( "disabled", true );
            $('#setting_business_postal_state').prop( "disabled", true );
            $('#setting_business_postal_postcode').prop( "disabled", true );

        }
        else {

            $('#setting_business_postal_address').val('');
            $('#setting_business_postal_suburb').val('');
            $('#setting_business_postal_state').val('');
            $('#setting_business_postal_postcode').val('');

            $('#setting_business_postal_address').prop( "disabled", false );
            $('#setting_business_postal_suburb').prop( "disabled", false );
            $('#setting_business_postal_state').prop( "disabled", false );
            $('#setting_business_postal_postcode').prop( "disabled", false );

        }


    };

    // Make postal address the same as street address
    $('#same_postal_address').on('change', samePostalAddress );
    $('#setting_business_address').bind("change paste keyup", samePostalAddress );
    $('#setting_business_suburb').bind("change paste keyup", samePostalAddress );
    $('#setting_business_state').bind("change paste keyup", samePostalAddress );
    $('#setting_business_postcode').bind("change paste keyup", samePostalAddress );

    // Find all tables and init
    $('#users_table').dataTable({
        responsive: true
    });


    // CREATE NEW USER
    $("#new_user").on("ajax:success", function (event, data, status, xhr) {

        // Clear form
        $("#new_user").find('input[type=text],input[type=file],input[type=password]').val('');
        // Clear classes
        $('.parsley-error').removeClass('parsley-error');
        $('.parsley-success').removeClass('parsley-success');
        // Remove errors
        $('.parsley-errors-list').children().empty();
        // Close modal
        $('#newUserModal').modal('hide')
        // Growl success
        $.growl("New user created.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-success"
        });
        // Add new user to list
        console.log(data);
        $('tr.highlight').removeClass('highlight');
        $('#users_table').children('tbody').prepend('<tr class="highlight"><td>'+data['first_name']+'</td><td>'+data['last_name']+'</td><td>'+data['email']+'</td><td id="user-'+data['id']+'-roles"><button class="btn btn-xs btn-success" data-toggle="modal" data-user-id="'+data['id'] +'" data-user-path="/user/'+data['id']+'" data-user-full-name="'+data['first_name']+' '+data['last_name']+'" data-target="#addRoleModal">Add <i class="fa fa-plus"></i></button></td><td></td></tr>');

    }).on("ajax:error", function (event, data, status, xhr) {

        // Remove errors
        $('.parsley-errors-list').children().empty();
        // Remove error class
        $('.parsley-error').removeClass('parsley-error');
        // Add new errors
        $.each(data.responseJSON, function(field_name, error_message){
            $('#user_'+field_name).removeClass('parsley-success').addClass('parsley-error');
            $('#user_'+field_name).siblings('ul.parsley-errors-list').append('<li>'+field_name.replace(/_/g, ' ')+' '+error_message+'</li>');
        });

    });

    // ADD NEW ROLE TO USER
    $(document).on('click', '[data-target="#addRoleModal"]', function() {

        $('#add_role_full_name').text($(this).attr('data-user-full-name'));
        $('#add_role_user_id').val($(this).attr('data-user-id'));
        $('#add_role_user_path').attr('href', $(this).attr('data-user-path'));

    });

    $("#new_add_role").on("ajax:success", function (event, data, status, xhr) {
        console.log(data);
        $('#addRoleModal').modal('hide');
        $.growl("Role added.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-success"
        });
        $('#user-'+data['user']['id']+'-roles').prepend('<button class="btn btn-xs btn-inverse capitalize" data-toggle="modal" data-target="#removeRoleModal" data-role-id="'+data['role']['id']+'" data-user-id="'+data['user']['id']+'" data-role-id-user-id="'+data['role']['id']+'-'+data['user']['id']+'">'+data['role']['name']+' <i class="fa fa-times"></i></button> ');
    }).on("ajax:error", function (event, data, status, xhr) {
        //console.log(data);
        $('#addRoleModal').modal('hide');
        $.growl("There was an error trying to add role.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-error"
        });
    });

    // REMOVE ROLE TO USER
    $(document).on('click', '[data-target="#removeRoleModal"]', function() {

        $('#remove_role_user_id').val($(this).attr('data-user-id'));
        $('#remove_role_role_id').val($(this).attr('data-role-id'));

    });

    $("#new_remove_role").on("ajax:success", function (event, data, status, xhr) {
        //console.log(data);
        $('#removeRoleModal').modal('hide');
        $.growl("Role removed.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-success"
        });
        $('[data-role-id-user-id="'+data['role']['id']+'-'+data['user']['id']+'"]').remove();
    }).on("ajax:error", function (event, data, status, xhr) {
        //console.log(data);
        $('#removeRoleModal').modal('hide');
        $.growl("There was an error trying to remove role.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-error"
        });
    });

    // DELETE USER
    $(document).on('click', '[data-target="#deleteUserModal"]', function() {

        $('#delete_user_id').val($(this).attr('data-user-id'));

    });

    $("#form_delete_user").on("ajax:success", function (event, data, status, xhr) {
        //console.log(status);
        //console.log(xhr);
        //console.log(data);
        $('#deleteUserModal').modal('hide');
        $.growl("User deleted.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-success"
        });
        $('[data-tr-user-id="'+data+'"]').remove();
    }).on("ajax:error", function (event, data, status, xhr) {
        console.log(status);
        console.log(xhr);
        console.log(data);
        $('#deleteUserModal').modal('hide');
        $.growl("There was an error trying to delete user.", {
            animate: {
                enter: 'animated fadeInRight',
                exit: 'animated fadeOutRight'
            },
            type: "growl-error"
        });
    });


    $('.datatable').dataTable({

    });




};

$(document).ready(admin);
$(document).on('page:load', admin);
