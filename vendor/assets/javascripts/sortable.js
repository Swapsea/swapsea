/*! sortable.js 0.5.1 */
(function() {
    var a, b, c, d, e, f, g;
    a = "table[data-sortable]", d = /^-?[£$¤]?[\d,.]+%?$/, g = /^\s+|\s+$/g, f = "ontouchstart"in document.documentElement, c = f ? "touchstart" : "click", b = function(a, b, c) {
        return null != a.addEventListener ? a.addEventListener(b, c, !1) : a.attachEvent("on" + b, c)
    }, e = {
        init: function(b) {
            var c, d, f, g, h;
            for (null == b && (b = {}), null == b.selector && (b.selector = a), d = document.querySelectorAll(b.selector)
                , h = [], f = 0, g = d.length;
            g > f;
            f++)c = d[f], h.push(e.initTable(c));
            return h
        },
        initTable: function(a) {
            var b, c, d, f, g, h;
            if (1 === (null != (h = a.tHead) ? h.rows.length : void 0) && "true" !== a.getAttribute("data-sortable-initialized")) {
                for (a.setAttribute("data-sortable-initialized", "true"), d = a.querySelectorAll("th")
                    , b = f = 0, g = d.length;
                g > f;
                b=++f)c = d[b], "false" !== c.getAttribute("data-sortable") && e.setupClickableTH(a, c, b);
                return a
            }
        },
        setupClickableTH: function(a, d, f) {
            var g;
            return g = e.getColumnType(a, f), b(d, c, function() {
                var b, c, h, i, j, k, l, m, n, o, p, q, r, s, t, u;
                for (j = "true" === this.getAttribute("data-sorted"), k = this.getAttribute("data-sorted-direction")
                    , b = j ? "ascending" === k ? "descending" : "ascending" : g.defaultSortDirection, m = this.parentNode.querySelectorAll("th"), n = 0, q = m.length;
                q > n;
                n++)d = m[n], d.setAttribute("data-sorted", "false"), d.removeAttribute("data-sorted-direction");
                for (this.setAttribute("data-sorted", "true"), this.setAttribute("data-sorted-direction", b), l = a.tBodies[0], h = [], t = l.rows, o = 0, r = t.length; r > o; o++)
                    c = t[o], h.push([e.getNodeValue(c.cells[f]), c]);
                for (j ? h.reverse() : h.sort(g.compare)
                    , u = [], p = 0, s = h.length;
                s > p;
                p++)i = h[p], u.push(l.appendChild(i[1]));
                return u
            })
        },
        getColumnType: function(a, b) {
            var c, f, g, h, i;
            for (i = a.tBodies[0].rows, g = 0, h = i.length; h > g; g++)
                if (c = i[g], f = e.getNodeValue(c.cells[b])
                    , "" !== f && f.match(d))return e.types.numeric;
            return e.types.alpha
        },
        getNodeValue: function(a) {
            return a ? null !== a.getAttribute("data-value") ? a.getAttribute("data-value") : "undefined" != typeof a.innerText ? a.innerText.replace(g, "") : a.textContent.replace(g, "") : ""
        },
        types: {
            numeric: {
                defaultSortDirection: "descending",
                compare: function(a, b) {
                    var c, d;
                    return c = parseFloat(a[0].replace(/[^0-9.-]/g, "")), d = parseFloat(b[0].replace(/[^0-9.-]/g, "")), isNaN(c) && (c = 0), isNaN(d) && (d = 0), d - c
                }
            },
            alpha: {
                defaultSortDirection: "ascending",
                compare: function(a, b) {
                    var c, d;
                    return c = a[0].toLowerCase(), d = b[0].toLowerCase(), c === d ? 0 : d > c?-1 : 1
                }
            }
        }
    }, setTimeout(e.init, 0), window.Sortable = e
}).call(this);
