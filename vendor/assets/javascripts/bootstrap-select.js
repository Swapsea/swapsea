/*!
 * bootstrap-select v1.4.2
 * http://silviomoreto.github.io/bootstrap-select/
 *
 * Copyright 2013 bootstrap-select
 * Licensed under the MIT license
 */
;
!function(b) {
    b.expr[":"].icontains = function(e, c, d) {
        return b(e).text().toUpperCase().indexOf(d[3].toUpperCase()) >= 0
    };
    var a = function(d, c, f) {
        if (f) {
            f.stopPropagation();
            f.preventDefault()
        }
        this.$element = b(d);
        this.$newElement = null;
        this.$button = null;
        this.$menu = null;
        this.options = b.extend({}, b.fn.selectpicker.defaults, this.$element.data(), typeof c == "object" && c);
        if (this.options.title === null) {
            this.options.title = this.$element.attr("title")
        }
        this.val = a.prototype.val;
        this.render = a.prototype.render;
        this.refresh = a.prototype.refresh;
        this.setStyle = a.prototype.setStyle;
        this.selectAll = a.prototype.selectAll;
        this.deselectAll = a.prototype.deselectAll;
        this.init()
    };
    a.prototype = {
        constructor: a,
        init: function() {
            this.$element.hide();
            this.multiple = this.$element.prop("multiple");
            var d = this.$element.attr("id");
            this.$newElement = this.createView();
            this.$element.after(this.$newElement);
            this.$menu = this.$newElement.find("> .dropdown-menu");
            this.$button = this.$newElement.find("> button");
            this.$searchbox = this.$newElement.find("input");
            if (d !== undefined) {
                var c = this;
                this.$button.attr("data-id", d);
                b('label[for="' + d + '"]').click(function(f) {
                    f.preventDefault();
                    c.$button.focus()
                })
            }
            this.checkDisabled();
            this.clickListener();
            if (this.options.liveSearch) {
                this.liveSearchListener()
            }
            this.render();
            this.liHeight();
            this.setStyle();
            this.setWidth();
            if (this.options.container) {
                this.selectPosition()
            }
            this.$menu.data("this", this);
            this.$newElement.data("this", this)
        },
        createDropdown: function() {
            var c = this.multiple ? " show-tick": "";
            var f = this.options.header ? '<div class="popover-title"><button type="button" class="close" aria-hidden="true">&times;</button>' + this.options.header + "</div>": "";
            var e = this.options.liveSearch ? '<div class="bootstrap-select-searchbox"><input type="text" class="input-block-level form-control" /></div>': "";
            var d = '<div class="btn-group bootstrap-select' + c + '"><button type="button" class="btn dropdown-toggle selectpicker" data-toggle="dropdown"><span class="filter-option pull-left"></span>&nbsp;<span class="caret"></span></button><div class="dropdown-menu open">' + f + e + '<ul class="dropdown-menu inner selectpicker" role="menu"></ul></div></div>';
            return b(d)
        },
        createView: function() {
            var c = this.createDropdown();
            var d = this.createLi();
            c.find("ul").append(d);
            return c
        },
        reloadLi: function() {
            this.destroyLi();
            var c = this.createLi();
            this.$menu.find("ul").append(c)
        },
        destroyLi: function() {
            this.$menu.find("li").remove()
        },
        createLi: function() {
            var d = this, e = [], c = "";
            this.$element.find("option").each(function() {
                var i = b(this);
                var g = i.attr("class") || "";
                var h = i.attr("style") || "";
                var m = i.data("content") ? i.data("content"): i.html();
                var k = i.data("subtext") !== undefined ? '<small class="muted text-muted">' + i.data("subtext") + "</small>": "";
                var j = i.data("icon") !== undefined ? '<i class="' + d.options.iconBase + " " + i.data("icon") + '"></i> ': "";
                if (j !== "" && (i.is(":disabled") || i.parent().is(":disabled"))) {
                    j = "<span>" + j + "</span>"
                }
                if (!i.data("content")) {
                    m = j + '<span class="text">' + m + k + "</span>"
                }
                if (d.options.hideDisabled && (i.is(":disabled") || i.parent().is(":disabled"))) {
                    e.push('<a style="min-height: 0; padding: 0"></a>')
                } else {
                    if (i.parent().is("optgroup") && i.data("divider") !== true) {
                        if (i.index() === 0) {
                            var l = i.parent().attr("label");
                            var n = i.parent().data("subtext") !== undefined ? '<small class="muted text-muted">' + i.parent().data("subtext") + "</small>": "";
                            var f = i.parent().data("icon") ? '<i class="' + i.parent().data("icon") + '"></i> ': "";
                            l = f + '<span class="text">' + l + n + "</span>";
                            if (i[0].index !== 0) {
                                e.push('<div class="div-contain"><div class="divider"></div></div><dt>' + l + "</dt>" + d.createA(m, "opt " + g, h))
                            } else {
                                e.push("<dt>" + l + "</dt>" + d.createA(m, "opt " + g, h))
                            }
                        } else {
                            e.push(d.createA(m, "opt " + g, h))
                        }
                    } else {
                        if (i.data("divider") === true) {
                            e.push('<div class="div-contain"><div class="divider"></div></div>')
                        } else {
                            if (b(this).data("hidden") === true) {
                                e.push("")
                            } else {
                                e.push(d.createA(m, g, h))
                            }
                        }
                    }
                }
            });
            b.each(e, function(f, g) {
                c += "<li rel=" + f + ">" + g + "</li>"
            });
            if (!this.multiple && this.$element.find("option:selected").length === 0&&!this.options.title) {
                this.$element.find("option").eq(0).prop("selected", true).attr("selected", "selected")
            }
            return b(c)
        },
        createA: function(e, c, d) {
            return '<a tabindex="0" class="' + c + '" style="' + d + '">' + e + '<i class="' + this.options.iconBase + " " + this.options.tickIcon + ' icon-ok check-mark"></i></a>'
        },
        render: function() {
            var d = this;
            this.$element.find("option").each(function(h) {
                d.setDisabled(h, b(this).is(":disabled") || b(this).parent().is(":disabled"));
                d.setSelected(h, b(this).is(":selected"))
            });
            this.tabIndex();
            var g = this.$element.find("option:selected").map(function() {
                var j = b(this);
                var i = j.data("icon") && d.options.showIcon ? '<i class="' + d.options.iconBase + " " + j.data("icon") + '"></i> ': "";
                var h;
                if (d.options.showSubtext && j.attr("data-subtext")&&!d.multiple) {
                    h = ' <small class="muted text-muted">' + j.data("subtext") + "</small>"
                } else {
                    h = ""
                }
                if (j.data("content") && d.options.showContent) {
                    return j.data("content")
                } else {
                    if (j.attr("title") !== undefined) {
                        return j.attr("title")
                    } else {
                        return i + j.html() + h
                    }
                }
            }).toArray();
            var f=!this.multiple ? g[0] : g.join(this.options.multipleSeparator);
            if (this.multiple && this.options.selectedTextFormat.indexOf("count")>-1) {
                var c = this.options.selectedTextFormat.split(">");
                var e = this.options.hideDisabled ? ":not([disabled])": "";
                if ((c.length > 1 && g.length > c[1]) || (c.length == 1 && g.length >= 2)) {
                    f = this.options.countSelectedText.replace("{0}", g.length).replace("{1}", this.$element.find('option:not([data-divider="true"]):not([data-hidden="true"])' + e).length)
                }
            }
            if (!f) {
                f = this.options.title !== undefined ? this.options.title : this.options.noneSelectedText
            }
            this.$button.attr("title", b.trim(f));
            this.$newElement.find(".filter-option").html(f)
        },
        setStyle: function(e, d) {
            if (this.$element.attr("class")) {
                this.$newElement.addClass(this.$element.attr("class").replace(/selectpicker|mobile-device/gi, ""))
            }
            var c = e ? e: this.options.style;
            if (d == "add") {
                this.$button.addClass(c)
            } else {
                if (d == "remove") {
                    this.$button.removeClass(c)
                } else {
                    this.$button.removeClass(this.options.style);
                    this.$button.addClass(c)
                }
            }
        },
        liHeight: function() {
            var e = this.$menu.parent().clone().appendTo("body"), f = e.addClass("open").find("> .dropdown-menu"), d = f.find("li > a").outerHeight(), c = this.options.header ? f.find(".popover-title").outerHeight(): 0, g = this.options.liveSearch ? f.find(".bootstrap-select-searchbox").outerHeight(): 0;
            e.remove();
            this.$newElement.data("liHeight", d).data("headerHeight", c).data("searchHeight", g)
        },
        setSize: function() {
            var h = this, d = this.$menu, i = d.find(".inner"), t = this.$newElement.outerHeight(), f = this.$newElement.data("liHeight"), r = this.$newElement.data("headerHeight"), l = this.$newElement.data("searchHeight"), k = d.find("li .divider").outerHeight(true), q = parseInt(d.css("padding-top")) + parseInt(d.css("padding-bottom")) + parseInt(d.css("border-top-width")) + parseInt(d.css("border-bottom-width")), o = this.options.hideDisabled ? ":not(.disabled)": "", n = b(window), g = q + parseInt(d.css("margin-top")) + parseInt(d.css("margin-bottom")) + 2, p, u, s, j = function() {
                u = h.$newElement.offset().top - n.scrollTop();
                s = n.height() - u - t
            };
            j();
            if (this.options.header) {
                d.css("padding-top", 0)
            }
            if (this.options.size == "auto") {
                var e = function() {
                    var v;
                    j();
                    p = s - g;
                    if (h.options.dropupAuto) {
                        h.$newElement.toggleClass("dropup", (u > s) && ((p - g) < d.height()))
                    }
                    if (h.$newElement.hasClass("dropup")) {
                        p = u - g
                    }
                    if ((d.find("li").length + d.find("dt").length) > 3) {
                        v = f * 3 + g-2
                    } else {
                        v = 0
                    }
                    d.css({
                        "max-height": p + "px",
                        overflow: "hidden",
                        "min-height": v + "px"
                    });
                    i.css({
                        "max-height": p - r - l - q + "px",
                        "overflow-y": "auto",
                        "min-height": v - q + "px"
                    })
                };
                e();
                b(window).resize(e);
                b(window).scroll(e)
            } else {
                if (this.options.size && this.options.size != "auto" && d.find("li" + o).length > this.options.size) {
                    var m = d.find("li" + o + " > *").filter(":not(.div-contain)").slice(0, this.options.size).last().parent().index();
                    var c = d.find("li").slice(0, m + 1).find(".div-contain").length;
                    p = f * this.options.size + c * k + q;
                    if (h.options.dropupAuto) {
                        this.$newElement.toggleClass("dropup", (u > s) && (p < d.height()))
                    }
                    d.css({
                        "max-height": p + r + l + "px",
                        overflow: "hidden"
                    });
                    i.css({
                        "max-height": p - q + "px",
                        "overflow-y": "auto"
                    })
                }
            }
        },
        setWidth: function() {
            if (this.options.width == "auto") {
                this.$menu.css("min-width", "0");
                var d = this.$newElement.clone().appendTo("body");
                var c = d.find("> .dropdown-menu").css("width");
                d.remove();
                this.$newElement.css("width", c)
            } else {
                if (this.options.width == "fit") {
                    this.$menu.css("min-width", "");
                    this.$newElement.css("width", "").addClass("fit-width")
                } else {
                    if (this.options.width) {
                        this.$menu.css("min-width", "");
                        this.$newElement.css("width", this.options.width)
                    } else {
                        this.$menu.css("min-width", "");
                        this.$newElement.css("width", "")
                    }
                }
            }
            if (this.$newElement.hasClass("fit-width") && this.options.width !== "fit") {
                this.$newElement.removeClass("fit-width")
            }
        },
        selectPosition: function() {
            var e = this, d = "<div />", f = b(d), h, g, c = function(i) {
                f.addClass(i.attr("class")).toggleClass("dropup", i.hasClass("dropup"));
                h = i.offset();
                g = i.hasClass("dropup") ? 0 : i[0].offsetHeight;
                f.css({
                    top: h.top + g,
                    left: h.left,
                    width: i[0].offsetWidth,
                    position: "absolute"
                })
            };
            this.$newElement.on("click", function() {
                c(b(this));
                f.appendTo(e.options.container);
                f.toggleClass("open", !b(this).hasClass("open"));
                f.append(e.$menu)
            });
            b(window).resize(function() {
                c(e.$newElement)
            });
            b(window).on("scroll", function() {
                c(e.$newElement)
            });
            b("html").on("click", function(i) {
                if (b(i.target).closest(e.$newElement).length < 1) {
                    f.removeClass("open")
                }
            })
        },
        mobile: function() {
            this.$element.addClass("mobile-device").appendTo(this.$newElement);
            if (this.options.container) {
                this.$menu.hide()
            }
        },
        refresh: function() {
            this.reloadLi();
            this.render();
            this.setWidth();
            this.setStyle();
            this.checkDisabled();
            this.liHeight()
        },
        update: function() {
            this.reloadLi();
            this.setWidth();
            this.setStyle();
            this.checkDisabled();
            this.liHeight()
        },
        setSelected: function(c, d) {
            this.$menu.find("li").eq(c).toggleClass("selected", d)
        },
        setDisabled: function(c, d) {
            if (d) {
                this.$menu.find("li").eq(c).addClass("disabled").find("a").attr("href", "#").attr("tabindex", -1)
            } else {
                this.$menu.find("li").eq(c).removeClass("disabled").find("a").removeAttr("href").attr("tabindex", 0)
            }
        },
        isDisabled: function() {
            return this.$element.is(":disabled")
        },
        checkDisabled: function() {
            var c = this;
            if (this.isDisabled()) {
                this.$button.addClass("disabled").attr("tabindex", -1)
            } else {
                if (this.$button.hasClass("disabled")) {
                    this.$button.removeClass("disabled")
                }
                if (this.$button.attr("tabindex")==-1) {
                    if (!this.$element.data("tabindex")) {
                        this.$button.removeAttr("tabindex")
                    }
                }
            }
            this.$button.click(function() {
                return !c.isDisabled()
            })
        },
        tabIndex: function() {
            if (this.$element.is("[tabindex]")) {
                this.$element.data("tabindex", this.$element.attr("tabindex"));
                this.$button.attr("tabindex", this.$element.data("tabindex"))
            }
        },
        clickListener: function() {
            var c = this;
            b("body").on("touchstart.dropdown", ".dropdown-menu", function(d) {
                d.stopPropagation()
            });
            this.$newElement.on("click", function() {
                c.setSize();
                if (!c.options.liveSearch&&!c.multiple) {
                    setTimeout(function() {
                        c.$menu.find(".selected a").focus()
                    }, 10)
                }
            });
            this.$menu.on("click", "li a", function(k) {
                var g = b(this).parent().index(), j = c.$element.val(), f = c.$element.prop("selectedIndex");
                if (c.multiple) {
                    k.stopPropagation()
                }
                k.preventDefault();
                if (!c.isDisabled()&&!b(this).parent().hasClass("disabled")) {
                    var d = c.$element.find("option");
                    var i = d.eq(g);
                    if (!c.multiple) {
                        d.prop("selected", false);
                        i.prop("selected", true)
                    } else {
                        var h = i.prop("selected");
                        i.prop("selected", !h)
                    }
                    if (!c.multiple) {
                        c.$button.focus()
                    } else {
                        if (c.options.liveSearch) {
                            c.$searchbox.focus()
                        }
                    }
                    if ((j != c.$element.val() && c.multiple) || (f != c.$element.prop("selectedIndex")&&!c.multiple)) {
                        c.$element.change()
                    }
                }
            });
            this.$menu.on("click", "li.disabled a, li dt, li .div-contain, .popover-title, .popover-title :not(.close)", function(d) {
                if (d.target == this) {
                    d.preventDefault();
                    d.stopPropagation();
                    if (!c.options.liveSearch) {
                        c.$button.focus()
                    } else {
                        c.$searchbox.focus()
                    }
                }
            });
            this.$menu.on("click", ".popover-title .close", function() {
                c.$button.focus()
            });
            this.$searchbox.on("click", function(d) {
                d.stopPropagation()
            });
            this.$element.change(function() {
                c.render()
            })
        },
        liveSearchListener: function() {
            var d = this, c = b('<li class="no-results"></li>');
            this.$newElement.on("click.dropdown.data-api", function() {
                d.$menu.find(".active").removeClass("active");
                if (!!d.$searchbox.val()) {
                    d.$searchbox.val("");
                    d.$menu.find("li").show();
                    if (!!c.parent().length) {
                        c.remove()
                    }
                }
                if (!d.multiple) {
                    d.$menu.find(".selected").addClass("active")
                }
                setTimeout(function() {
                    d.$searchbox.focus()
                }, 10)
            });
            this.$searchbox.on("input propertychange", function() {
                if (d.$searchbox.val()) {
                    d.$menu.find("li").show().not(":icontains(" + d.$searchbox.val() + ")").hide();
                    if (!d.$menu.find("li").filter(":visible:not(.no-results)").length) {
                        if (!!c.parent().length) {
                            c.remove()
                        }
                        c.html('No results match "' + d.$searchbox.val() + '"').show();
                        d.$menu.find("li").last().after(c)
                    } else {
                        if (!!c.parent().length) {
                            c.remove()
                        }
                    }
                } else {
                    d.$menu.find("li").show();
                    if (!!c.parent().length) {
                        c.remove()
                    }
                }
                d.$menu.find("li.active").removeClass("active");
                d.$menu.find("li").filter(":visible:not(.divider)").eq(0).addClass("active").find("a").focus();
                b(this).focus()
            });
            this.$menu.on("mouseenter", "a", function(f) {
                d.$menu.find(".active").removeClass("active");
                b(f.currentTarget).parent().not(".disabled").addClass("active")
            });
            this.$menu.on("mouseleave", "a", function() {
                d.$menu.find(".active").removeClass("active")
            })
        },
        val: function(c) {
            if (c !== undefined) {
                this.$element.val(c);
                this.$element.change();
                return this.$element
            } else {
                return this.$element.val()
            }
        },
        selectAll: function() {
            this.$element.find("option").prop("selected", true).attr("selected", "selected");
            this.render()
        },
        deselectAll: function() {
            this.$element.find("option").prop("selected", false).removeAttr("selected");
            this.render()
        },
        keydown: function(p) {
            var q, o, i, n, k, j, r, f, h, m, d, s, g = {
                32: " ",
                48: "0",
                49: "1",
                50: "2",
                51: "3",
                52: "4",
                53: "5",
                54: "6",
                55: "7",
                56: "8",
                57: "9",
                59: ";",
                65: "a",
                66: "b",
                67: "c",
                68: "d",
                69: "e",
                70: "f",
                71: "g",
                72: "h",
                73: "i",
                74: "j",
                75: "k",
                76: "l",
                77: "m",
                78: "n",
                79: "o",
                80: "p",
                81: "q",
                82: "r",
                83: "s",
                84: "t",
                85: "u",
                86: "v",
                87: "w",
                88: "x",
                89: "y",
                90: "z",
                96: "0",
                97: "1",
                98: "2",
                99: "3",
                100: "4",
                101: "5",
                102: "6",
                103: "7",
                104: "8",
                105: "9"
            };
            q = b(this);
            i = q.parent();
            if (q.is("input")) {
                i = q.parent().parent()
            }
            m = i.data("this");
            if (m.options.liveSearch) {
                i = q.parent().parent()
            }
            if (m.options.container) {
                i = m.$menu
            }
            o = b("[role=menu] li:not(.divider) a", i);
            s = m.$menu.parent().hasClass("open");
            if (m.options.liveSearch) {
                if (/(^9$|27)/.test(p.keyCode) && s && m.$menu.find(".active").length === 0) {
                    p.preventDefault();
                    m.$menu.parent().removeClass("open");
                    m.$button.focus()
                }
                o = b("[role=menu] li:not(.divider):visible", i);
                if (!q.val()&&!/(38|40)/.test(p.keyCode)) {
                    if (o.filter(".active").length === 0) {
                        o = m.$newElement.find("li").filter(":icontains(" + g[p.keyCode] + ")")
                    }
                }
            }
            if (!o.length) {
                return
            }
            if (/(38|40)/.test(p.keyCode)) {
                if (!s) {
                    m.$menu.parent().addClass("open")
                }
                n = o.index(o.filter(":focus"));
                j = o.parent(":not(.disabled):visible").first().index();
                r = o.parent(":not(.disabled):visible").last().index();
                k = o.eq(n).parent().nextAll(":not(.disabled):visible").eq(0).index();
                f = o.eq(n).parent().prevAll(":not(.disabled):visible").eq(0).index();
                h = o.eq(k).parent().prevAll(":not(.disabled):visible").eq(0).index();
                if (m.options.liveSearch) {
                    o.each(function(e) {
                        if (b(this).is(":not(.disabled)")) {
                            b(this).data("index", e)
                        }
                    });
                    n = o.index(o.filter(".active"));
                    j = o.filter(":not(.disabled):visible").first().data("index");
                    r = o.filter(":not(.disabled):visible").last().data("index");
                    k = o.eq(n).nextAll(":not(.disabled):visible").eq(0).data("index");
                    f = o.eq(n).prevAll(":not(.disabled):visible").eq(0).data("index");
                    h = o.eq(k).prevAll(":not(.disabled):visible").eq(0).data("index")
                }
                d = q.data("prevIndex");
                if (p.keyCode == 38) {
                    if (m.options.liveSearch) {
                        n -= 1
                    }
                    if (n != h && n > f) {
                        n = f
                    }
                    if (n < j) {
                        n = j
                    }
                    if (n == d) {
                        n = r
                    }
                }
                if (p.keyCode == 40) {
                    if (m.options.liveSearch) {
                        n += 1
                    }
                    if (n==-1) {
                        n = 0
                    }
                    if (n != h && n < k) {
                        n = k
                    }
                    if (n > r) {
                        n = r
                    }
                    if (n == d) {
                        n = j
                    }
                }
                q.data("prevIndex", n);
                if (!m.options.liveSearch) {
                    o.eq(n).focus()
                } else {
                    p.preventDefault();
                    if (!q.is(".dropdown-toggle")) {
                        o.removeClass("active");
                        o.eq(n).addClass("active").find("a").focus();
                        q.focus()
                    }
                }
            } else {
                if (!q.is("input")) {
                    var c = [], l, t;
                    o.each(function() {
                        if (b(this).parent().is(":not(.disabled)")) {
                            if (b.trim(b(this).text().toLowerCase()).substring(0, 1) == g[p.keyCode]) {
                                c.push(b(this).parent().index())
                            }
                        }
                    });
                    l = b(document).data("keycount");
                    l++;
                    b(document).data("keycount", l);
                    t = b.trim(b(":focus").text().toLowerCase()).substring(0, 1);
                    if (t != g[p.keyCode]) {
                        l = 1;
                        b(document).data("keycount", l)
                    } else {
                        if (l >= c.length) {
                            b(document).data("keycount", 0);
                            if (l > c.length) {
                                l = 1
                            }
                        }
                    }
                    o.eq(c[l-1]).focus()
                }
            }
            if (/(13|32|^9$)/.test(p.keyCode) && s) {
                if (!/(32)/.test(p.keyCode)) {
                    p.preventDefault()
                }
                if (!m.options.liveSearch) {
                    b(":focus").click()
                } else {
                    if (!/(32)/.test(p.keyCode)) {
                        m.$menu.find(".active a").click();
                        q.focus()
                    }
                }
                b(document).data("keycount", 0)
            }
            if ((/(^9$|27)/.test(p.keyCode) && s && (m.multiple || m.options.liveSearch)) || (/(27)/.test(p.keyCode)&&!s)) {
                m.$menu.parent().removeClass("open");
                m.$button.focus()
            }
        },
        hide: function() {
            this.$newElement.hide()
        },
        show: function() {
            this.$newElement.show()
        },
        destroy: function() {
            this.$newElement.remove();
            this.$element.remove()
        }
    };
    b.fn.selectpicker = function(e, f) {
        var c = arguments;
        var g;
        var d = this.each(function() {
            if (b(this).is("select")) {
                var m = b(this), l = m.data("selectpicker"), h = typeof e == "object" && e;
                if (!l) {
                    m.data("selectpicker", (l = new a(this, h, f)))
                } else {
                    if (h) {
                        for (var j in h) {
                            l.options[j] = h[j]
                        }
                    }
                }
                if (typeof e == "string") {
                    var k = e;
                    if (l[k] instanceof Function) {
                        [].shift.apply(c);
                        g = l[k].apply(l, c)
                    } else {
                        g = l.options[k]
                    }
                }
            }
        });
        if (g !== undefined) {
            return g
        } else {
            return d
        }
    };
    b.fn.selectpicker.defaults = {
        style: "btn-default",
        size: "auto",
        title: null,
        selectedTextFormat: "values",
        noneSelectedText: "Nothing selected",
        countSelectedText: "{0} of {1} selected",
        width: false,
        container: false,
        hideDisabled: false,
        showSubtext: false,
        showIcon: true,
        showContent: true,
        dropupAuto: true,
        header: false,
        liveSearch: false,
        multipleSeparator: ", ",
        iconBase: "glyphicon",
        tickIcon: "glyphicon-ok"
    };
    b(document).data("keycount", 0).on("keydown", ".bootstrap-select [data-toggle=dropdown], .bootstrap-select [role=menu], .bootstrap-select-searchbox input", a.prototype.keydown).on("focusin.modal", ".bootstrap-select [data-toggle=dropdown], .bootstrap-select [role=menu], .bootstrap-select-searchbox input", function(c) {
        c.stopPropagation()
    })
}(window.jQuery);
