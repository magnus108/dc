var $settings = drupalSettings.gavias_sliderlayer.settings,
    $group_settings = drupalSettings.gavias_sliderlayer.group_settings,
    $layers = drupalSettings.gavias_sliderlayer.layers_settings,
    $cxt = 0;
"null" == $layers && ($layers = new Array), "null" == $settings && ($settings = {}), "null" == $group_settings && ($group_settings = {
    startwidth: 1170,
    startheight: 600
});
var delayer = drupalSettings.gavias_sliderlayer.delayer,
    deslider = drupalSettings.gavias_sliderlayer.deslider,
    key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
base64Encode = function(e) {
        var t, a, s, i, n, r, l, d = "",
            o = 0;
        for (e = UTF8Encode(e); o < e.length;) t = e.charCodeAt(o++), a = e.charCodeAt(o++), s = e.charCodeAt(o++), i = t >> 2, n = (3 & t) << 4 | a >> 4, r = (15 & a) << 2 | s >> 6, l = 63 & s, isNaN(a) ? r = l = 64 : isNaN(s) && (l = 64), d = d + key.charAt(i) + key.charAt(n) + key.charAt(r) + key.charAt(l);
        return d
    }, UTF8Encode = function(e) {
        e = e.replace(/\x0d\x0a/g, "\n");
        for (var t = "", a = 0; a < e.length; a++) {
            var s = e.charCodeAt(a);
            128 > s ? t += String.fromCharCode(s) : s > 127 && 2048 > s ? (t += String.fromCharCode(s >> 6 | 192), t += String.fromCharCode(63 & s | 128)) : (t += String.fromCharCode(s >> 12 | 224), t += String.fromCharCode(s >> 6 & 63 | 128), t += String.fromCharCode(63 & s | 128))
        }
        return t
    }, GaviasCompare = function(e, t) {
        return e.index < t.index ? -1 : e.index > t.index ? 1 : 0
    },
    function(e) {
        function t(t, a) {
            e.notify({
                title: "Notification",
                text: a,
                image: '<i class="fa fa-bell" style="font-size: 30px;color: #fff;"></i>',
                hideAnimation: "slideUp"
            }, {
                style: "metro",
                className: t,
                autoHide: !0,
                clickToHide: !0
            })
        }

        function a() {
            $settings = e.extend(!0, deslider, $settings), "" != $settings.background_image_uri ? e("#gavias_slider_single").css({
                "background-image": "url(" + drupalSettings.gavias_sliderlayer.base_url + $settings.background_image_uri + ")"
            }) : e("#gavias_slider_single").css({
                backgroundImage: "none"
            }), jQuery(".slide-option").each(function(e) {
                "undefined" != typeof $settings[jQuery(this).attr("name")] ? jQuery(this).val($settings[jQuery(this).attr("name")]) : jQuery(this).val("")
            }), n()
        }

        function s() {
            e("input.slide-option, select.slide-option").each(function(t) {
                $settings[e(this).attr("name")] = e(this).val()
            })
        }

        function i(t, a, s) {
            t.title = t.title || "Layer " + (a + 1);
            var i = e("<span>").text($layers[a].title),
                n = e("<span>").text("").addClass("remove-layer fa fa-times"),
                r = e("<span>").text("").addClass("fa fa-clone"),
                l = e("<span>").text("").addClass("move fa fa-arrows");
            i.click(function() {
                u(), c(a)
            }), r.click(function() {
                u(), d(a)
            }), n.click(function() {
                g(a)
            }), s.append(i).append(n).append(r).append(l)
        }

        function n() {
            e("#gavias_slider_single").find("div").remove(), e("#gavias_list_layers").find("li").remove(), "undefined" == typeof $layers && ($layers = new Array), e($layers).each(function(e) {
                $layers[e] && 1 != $layers[e].removed && l(e)
            }), e(".layer-option").val(""), "undefined" != typeof $layers[0] && c(0)
        }

        function r() {
            u();
            var t = $layers.length;
            $layers[t] = {}, $start_layer = 0, e.each($layers, function(e, t) {
                parseInt(t.data_time_start) > $start_layer && ($start_layer = t.data_time_start)
            }), delayer.data_time_start = parseInt($start_layer) + 500, e.extend(!0, $layers[t], delayer), l(t), c(t)
        }

        function l(t) {
            var n = $layers[t].type,
                r = e("<li>").attr("index", t).addClass(n);
            i($layers[t], t, r), e("ul#gavias_list_layers").append(r);
            var l = e("<div>").addClass("layer tp-caption").attr("id", "layer-" + t);
            l.addClass("caption"), "undefined" == typeof $layers[t].text_style && ($layers[t].text_style = "text"), "text" == $layers[t].type && l.addClass($layers[t].text_style);
            var d = "";
            switch ($layers[t].type) {
                case "image":
                    var o = drupalSettings.gavias_sliderlayer.base_url + $layers[t].image_uri;
                    d = '<img src="' + o + '" />';
                    var g = new Image;
                    g.onload = function() {
                        l.width($layers[t].width || this.width), l.height($layers[t].height || this.height)
                    }, g.src = drupalSettings.gavias_sliderlayer.base_url + $layers[t].image_uri;
                    break;
                case "text":
                    d = $layers[t].text
            }
            var h = e("<div>").addClass("inner");
            $layers[t].custom_css && h.attr("style", $layers[t].custom_css), $layers[t].custom_class && h.addClass($layers[t].custom_class), $layers[t].custom_style && h.addClass($layers[t].custom_style), h.html(d), l.append(h);
            var p = 99 - $layers[t].index;
            l.mousedown(function() {
                u(), c(t)
            }).draggable({
                containment: "parent",
                drag: function(a, s) {
                    e("input[name=left]").val(s.position.left), e("input[name=top]").val(s.position.top), y(t, s.position.top, s.position.left)
                },
                grid: [5, 5]
            }).resizable({
                aspectRatio: "image" == $layers[t].type,
                resize: function(t, a) {
                    e("input[name=width]").val(a.size.width), e("input[name=height]").val(a.size.height)
                }
            }), e("#gavias_slider_single").append(l);
            var v = $layers[t].left,
                f = $layers[t].type,
                _ = l.width();
            "image" == f && (_ = $layers[t].width), "center" == v ? l.css({
                left: "50%",
                "margin-left": -(_ / 2)
            }) : "left" == v ? l.css({
                left: 0
            }) : "right" == v ? l.css({
                right: 0
            }) : l.css({
                left: v + "px"
            }), l.css({
                top: $layers[t].top + "px",
                zIndex: p
            }), e("#layeroptions").show(0), e("#gavias_list_layers").sortable({
                handle: ".move",
                update: function(t, i) {
                    e("#gavias_list_layers").find("li").each(function(t) {
                        var a = e(this).attr("index");
                        $layers[a].index = t, e("#layer-" + a).css({
                            zIndex: 99 - t
                        }), u()
                    }), $layers.sort(GaviasCompare), s(), a()
                }
            })
        }

        function d(t) {
            u();
            var a = $layers.length;
            $layers[a] = {}, $start_layer = 0, e.each($layers, function(e, t) {
                parseInt(t.data_time_start) > $start_layer && ($start_layer = t.data_time_start)
            }), e.extend(!0, $layers[a], $layers[t]), l(a), c(a)
        }

        function o(t) {
            if (e(".g-content-setting").each(function() {
                    e(this).css("display", "none")
                }), e("#content-" + t).css("display", "block"), $layers[$cxt].type = t, e("ul#gavias_list_layers li.active").removeClass("image text").addClass(t), "image" == t) {
                var a = e("#0-" + $cxt).resizable("option");
                e("#layer-" + $cxt).resizable("destroy"), a.aspectRatio = !0, e("#layer-" + $cxt).resizable(a)
            } else if ("text" == t) {
                e("#content-" + t).find("textarea[id=layer-text]").trigger("keyup");
                var s = e("#layer-" + $cxt).resizable("option");
                e("#layer-" + $cxt).resizable("destroy"), s.aspectRatio = !1, e("#layer-" + $cxt).resizable(s)
            }
        }

        function c(t) {
            $cxt = t, e(".layer").removeClass("selected"), e("#layer-" + t).addClass("selected"), e("ul#gavias_list_layers").find("li").removeClass("active"), e("ul#gavias_list_layers").find("li[index=" + t + "]").addClass("active"), e(".layer-option").each(function(a) {
                "undefined" != typeof $layers[t][e(this).attr("name")] ? "data_time_end" == e(this).attr("name") || "data_time_start" == e(this).attr("name") ? e(this).val($layers[t][e(this).attr("name")]).trigger("change") : e(this).val($layers[t][e(this).attr("name")]) : e(this).val("")
            });
            var a = $layers[t].select_content_type;
            o(a), e(".select-content-type").change(function() {
                var t = e(this).val();
                o(t)
            })
        }

        function y(e, t, a) {
            $layers[e].top = t, $layers[e].left = a
        }

        function u() {
            0 != $layers.length && e(".layer-option").each(function(t) {
                "undefined" != e(this) && ($layers[$cxt][e(this).attr("name")] = e(this).val())
            })
        }

        function g(t) {
            if (e("#layer-" + t).remove(), $layers[t].removed = 1, e("ul#gavias_list_layers").find("li[index=" + t + "]").remove(), t == $cxt && e("ul#gavias_list_layers li").length > 0) {
                var a = parseInt(e("ul#gavias_list_layers").find("li:first").attr("index"));
                c(a)
            }
        }

        function h() {
            s(), u();
            var a = [];
            $layers.sort(GaviasCompare), e.each($layers, function(e, t) {
                0 == t.removed && (a[a.length] = t)
            }), $layers = a;
            var i = e.extend(!0, {}, $settings),
                n = base64Encode(JSON.stringify(i)),
                r = base64Encode(JSON.stringify(a)),
                l = e("input[name=gid]").val(),
                d = e("input[name=sid]").val(),
                o = e("input[name=title]").val(),
                c = e("input[name=sort_index]").val(),
                y = e("select[name=status]").val(),
                g = e("input[name=background_image_uri]").val(),
                h = {
                    sort_index: c,
                    status: y,
                    title: o,
                    sid: d,
                    gid: l,
                    background_image_uri: g,
                    datalayers: r,
                    settings: n
                };
            e.ajax({
                url: drupalSettings.gavias_sliderlayer.save_url,
                type: "POST",
                data: h,
                dataType: "json",
                success: function(a) {
                    e("#save").val("Save"), t("success", "Slider updated"), e("#save").removeAttr("disabled"), window.location = a.url_edit
                },
                error: function(a, s, i) {
                    t("black", "Slider not updated"), e("#save").removeAttr("disabled")
                }
            })
        }
        e(window).load(function() {
            e('input[name*="video_youtube_args"').val() || e('input[name*="video_youtube_args"').val("version=3&enablejsapi=1&html5=1&hd=1&wmode=opaque&showinfo=0&ref=0;origin=http://server.local;autoplay=1;"), e('input[name*="video_vimeo_args"').val() || e('input[name*="video_vimeo_args"').val("title=0&byline=0&portrait=0&api=1")
        }), e(document).ready(function() {
            function t(t) {
                var a = "layer-" + $cxt,
                    s = e("<img>").attr("src", t);
                e("#" + a).find(".inner").html(s);
                var i = new Image;
                i.onload = function() {
                    e("#" + a).width(this.width), e("#" + a).height(this.height), e("input[name=width]").val(this.width), e("input[name=height]").val(this.height)
                }, i.src = t
            }

            function s(e) {
                jQuery("#gavias_slider_single").css({
                    backgroundImage: "url(" + e + ")"
                })
            }
            var i = 9e3;
            $group_settings.delay && (i = $group_settings.delay);
            var n = document.getElementById("g-slider");
            noUiSlider.create(n, {
                start: [20, parseInt(i) - 20],
                margin: 20,
                connect: !0,
                behaviour: "tap-drag",
                range: {
                    min: 0,
                    max: parseInt(i)
                },
                pips: {
                    mode: "steps",
                    density: 2
                }
            });
            var l = document.getElementById("g_data_end"),
                d = document.getElementById("g_data_start");
            n.noUiSlider.on("update", function(e, t) {
                t ? l.value = e[t] : d.value = e[t]
            }), e("#g_data_end").on("change", function() {
                n.noUiSlider.set([null, this.value])
            }), e("#g_data_start").on("change", function() {
                n.noUiSlider.set([this.value, null])
            }), e("select[name=text_style]").change(function() {
                e(".layer[id=layer-" + $cxt + "] .inner").attr("class", "inner " + $layers[$cxt].custom_class + " " + $layers[$cxt].custom_style), e(".layer[id=layer-" + $cxt + "] .inner").addClass(e(this).val())
            }), e("#content-type").find("#layer-text").keyup(function() {
                $layers[$cxt].text = e(this).val(), e("#layer-" + $cxt).find(".inner").html(e(this).val())
            }), e("[name=custom_css]").keyup(function() {
                $layers[$cxt].custom_css = e(this).val(), e("#layer-" + $cxt).find(".inner").attr("style", e(this).val())
            }), e("[name=custom_class]").change(function() {
                $layers[$cxt].custom_class = e(this).val(), e("#layer-" + $cxt).find(".inner").attr("class", "inner"), e("#layer-" + $cxt).find(".inner").addClass(e(this).val()), e("#layer-" + $cxt).find(".inner").addClass(e(this).parents(".fieldset-wrapper").find("[name=custom_style]").val())
            }), e("[name=custom_style]").change(function() {
                $layers[$cxt].custom_style = e(this).val(), e("#layer-" + $cxt).find(".inner").attr("class", "inner"), e("#layer-" + $cxt).find(".inner").addClass(e(this).val()), e("#layer-" + $cxt).find(".inner").addClass(e(this).parents(".fieldset-wrapper").find("[name=custom_class]").val())
            }), e("#gavias_slider_single").width($group_settings.startwidth).height($group_settings.startheight), e("input[name=top]").change(function() {
                e("#layer-" + $cxt).css({
                    top: e(this).val() + "px"
                })
            }), e("input[name=left]").on("change", function() {
                "center" == e(this).val() ? e("#layer-" + $cxt).css({
                    left: "50%",
                    "margin-left": -(e("#layer-" + $cxt).width() / 2)
                }) : "left" == e(this).val() ? e("#layer-" + $cxt).css({
                    left: 0
                }) : "right" == e(this).val() ? e("#layer-" + $cxt).css({
                    right: 0
                }) : e("#layer-" + $cxt).css({
                    left: e(this).val() + "px"
                })
            }), e("input[name=width]").change(function() {
                e("#layer-" + $cxt).css({
                    width: e(this).val() + "px"
                })
            }), e("input[name=height]").change(function() {
                e("#layer-" + $cxt).css({
                    height: e(this).val() + "px"
                })
            }), a(), e("#add_layer").click(function() {
                return r(), !1
            }), e("#save").click(function() {
                e(this).attr("disabled", "true"), h()
            }), e("input#g-image-layer").on("onchange", function() {
                $url = drupalSettings.gavias_sliderlayer.base_url + e(this).val(), t($url)
            }), e("input#background-image").on("onchange", function() {
                $url = drupalSettings.gavias_sliderlayer.base_url + e(this).val(), s($url)
            })
        }), window.set_layer_position = y
    }(jQuery);