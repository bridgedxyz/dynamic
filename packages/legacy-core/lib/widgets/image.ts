import { View } from "../_ui"

interface I_ImageOptions {

}

export class Image extends View {
    type: string = "image";
    src: string
    options?: I_ImageOptions
    constructor(src: string, options?: I_ImageOptions) {
        super()
        this.src = src;
        this.options = options
    }
}