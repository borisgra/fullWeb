@file:JsModule("react-share") // https://www.npmjs.com/package/react-share
@file:JsNonModule

import react.ComponentClass
import react.Props

@JsName("EmailIcon")
external val emailIcon: ComponentClass<IconProps>

@JsName("EmailShareButton")
external val emailShareButton: ComponentClass<ShareButtonProps>

@JsName("TelegramIcon")
external val telegramIcon: ComponentClass<IconProps>

@JsName("TelegramShareButton")
external val telegramShareButton: ComponentClass<ShareButtonProps>

@JsName("ViberShareButton")
external val viberShareButton: ComponentClass<ShareButtonProps>

@JsName("ViberIcon")
external val viberIcon: ComponentClass<IconProps>

@JsName("VKShareButton")
external val vkShareButton: ComponentClass<ShareButtonProps>

@JsName("VKIcon")
external val vkIcon: ComponentClass<IconProps>

@JsName("WhatsappShareButton")
external val whatsappShareButton: ComponentClass<ShareButtonProps>

@JsName("WhatsappIcon")
external val whatsappIcon: ComponentClass<IconProps>

external interface ShareButtonProps : Props {
    var url: String
}

external interface IconProps : Props {
    var size: Int
    var round: Boolean
}