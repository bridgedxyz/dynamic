import { View } from "../_ui";
import { Text } from "./text";

export class Chip extends View {
    type: string = "chip";
    label: Text
    avatar?: View

    constructor(label: Text,) {
        super();
        this.label = label;
    }
}