// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AjaxRenderController from "./ajax_render_controller"
application.register("ajax-render", AjaxRenderController)

import FormController from "./form_controller"
application.register("form", FormController)

import FormatPhoneNumberController from "./format_phone_number_controller"
application.register("format-phone-number", FormatPhoneNumberController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MapController from "./map_controller"
application.register("map", MapController)
