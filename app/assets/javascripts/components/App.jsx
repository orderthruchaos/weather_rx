import { StrictMode } from "react"
import { createRoot } from "react-dom/client"
import Header from "./header"

const root = createRoot(document.getElementById("root"))

root.render(
    <>
        <StrictMode />
        <Header />
        <p>hello</p>
    </>
)

// vim: sw=4 sts=4 ts=8 et
