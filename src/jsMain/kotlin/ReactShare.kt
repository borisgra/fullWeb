@file:JsModule("react-share") // https://www.npmjs.com/package/react-share
@file:JsNonModule

import react.RClass
import react.RProps

@JsName("EmailIcon")
external val emailIcon: RClass<IconProps>

@JsName("EmailShareButton")
external val emailShareButton: RClass<ShareButtonProps>

@JsName("TelegramIcon")
external val telegramIcon: RClass<IconProps>

@JsName("TelegramShareButton")
external val telegramShareButton: RClass<ShareButtonProps>

@JsName("ViberShareButton")
external val viberShareButton: RClass<ShareButtonProps>

@JsName("ViberIcon")
external val viberIcon: RClass<IconProps>

@JsName("VKShareButton")
external val vkShareButton: RClass<ShareButtonProps>

@JsName("VKIcon")
external val vkIcon: RClass<IconProps>

@JsName("WhatsappShareButton")
external val whatsappShareButton: RClass<ShareButtonProps>

@JsName("WhatsappIcon")
external val whatsappIcon: RClass<IconProps>

external interface ShareButtonProps : RProps {
    var url: String
}

external interface IconProps : RProps {
    var size: Int
    var round: Boolean
}