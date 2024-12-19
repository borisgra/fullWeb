@file:JsModule("react-share") // https://www.npmjs.com/package/react-share
@file:JsNonModule

import react.ComponentClass
import react.Props

@JsName("EmailIcon")
external var emailIcon: ComponentClass<IconProps>

@JsName("EmailShareButton")
external var emailShareButton: ComponentClass<ShareButtonProps>

@JsName("TelegramIcon")
external var telegramIcon: ComponentClass<IconProps>

@JsName("TelegramShareButton")
external var telegramShareButton: ComponentClass<ShareButtonProps>

@JsName("ViberShareButton")
external var viberShareButton: ComponentClass<ShareButtonProps>

@JsName("ViberIcon")
external var viberIcon: ComponentClass<IconProps>

@JsName("VKShareButton")
external var vkShareButton: ComponentClass<ShareButtonProps>

@JsName("VKIcon")
external var vkIcon: ComponentClass<IconProps>

@JsName("WhatsappShareButton")
external var whatsappShareButton: ComponentClass<ShareButtonProps>

@JsName("WhatsappIcon")
external var whatsappIcon: ComponentClass<IconProps>

external interface ShareButtonProps : Props {
    var url: String
}

external interface IconProps : Props {
    var size: Int
    var round: Boolean
}