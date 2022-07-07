import react.*
import react.dom.*
import kotlinx.html.js.*
import kotlinx.html.InputType
import org.w3c.dom.events.Event
import org.w3c.dom.HTMLInputElement

external interface InputProps : RProps {
    var onSubmit: (String) -> Unit
    var placeholder: String
}

val InputComponent = functionalComponent<InputProps> { props ->
    val (text, setText) = useState("")

    val submitHandler: (Event) -> Unit = {
        it.preventDefault()
        setText("") // before .onSubmit
        props.onSubmit(text)
    }

    form {
        attrs.onSubmitFunction = submitHandler
        input(if (props.placeholder != ADMIN_PASSW) InputType.text else InputType.password) {
            attrs.onChangeFunction = {
                setText((it.target as HTMLInputElement).value)
            }
            attrs.placeholder = props.placeholder
            attrs.value = text
            attrs.size = text.length.toString()
        }
    }
}