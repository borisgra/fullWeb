@file:Suppress("unused", "PropertyName")
@file:JsModule("mui-nested-menu") // https://github.com/steviebaa/mui-nested-menu
@file:JsNonModule

import react.*

@JsName("NestedDropdown")
external val nestedMenu: ComponentClass<NestedMenuProps>

external interface NestedMenuProps : Props {
    var menuItemsData: dynamic
    var MenuProps: dynamic
    var ButtonProps: dynamic
    var onClick: Any
}
