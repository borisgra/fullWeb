import web.cssom.ClassName
import mui.material.FormControlVariant
import mui.material.TextField
import mui.material.TextFieldColor
import react.*
import web.html.InputType
import react.dom.html.ReactHTML.form
import react.dom.html.ReactHTML.input
import react.dom.onChange

external interface InputProps : Props {
    var onSubmit: (String) -> Unit
    var placeholder: String
}

val InputFC = FC<InputProps> { props ->
    var text by useState("")

    form {
        onSubmit = {
            it.preventDefault()
            text = "" // before .onSubmit
            props.onSubmit(text)
        }
        input {
            id = "inputAny"
            onChange = {
                text = it.target.value
            }
            placeholder = props.placeholder
            type = if (props.placeholder != ADMIN_PASSW) InputType.text else InputType.password
            value = text
            size = text.length
            className = ClassName("cl3")
        }
    }
}

external interface FieldDateProps : Props {
    var id: String
    var label: String
    var defaultValue: String
    var onChange: (Any) -> Unit
}

val FieldDateFC = FC<FieldDateProps> { props ->
    TextField{
        id = props.id
        label = ReactNode(props.label)
        color = TextFieldColor.secondary
        @Suppress("unused")
        asDynamic().inputProps = object { // InputProps={{ sx: { height: 80 } }}
            val min = DATE_MIN //inputProps={{ min: "2019-01-01", max: "2027-12-31" }}
            val max = DATE_MAX
            val sx = object {
                val background = "#b3ffb3"
                val height = 15
            }
        }
        type = InputType.date
        variant = FormControlVariant.standard
        placeholder="DD.MM.YYYY"
        required = true
        defaultValue = props.defaultValue // "yyyy-MM-dd".
        className = ClassName("cl3")
        onChange = props.onChange
    }
}