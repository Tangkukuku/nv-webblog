<template>
    <div>
        <h1>Create Blog</h1>
        <form v-on:submit.prevent = "createBlog">
        <p>title: <input type="text" v-model="blog.title"></p>
        <p><strong>content: </strong></p>
        <p><vue-ckeditor v-model.lazy="blog.content" :config="config" @blur="onBlur($event)" @focus="onFocus($event)" /></p>
        <p>category: <input type="text" v-model="blog.category"></p>
        <p>status: <input type="text" v-model="blog.status"></p>
        <p><button type="submit">create blog</button></p>
        </form>
    </div>
</template>
<script>
import BlogsService from '@/services/BlogsService'
import VueCkeditor from "vue-ckeditor2"
export default {
    data () {
        return {
            blog: {
                title: '',
                thumbnail: 'null',
                pictures: 'null',
                content: '',
                category: '',
                status: ''
            },
            config: {
                toolbar: [
                    ["Bold", "Italic", "Underline", "Strike", "Subscript","Superscript"]
                ],
                height: 300
            },
        }
    },
    methods: {
        async createBlog () {
            try {
                await BlogsService.post(this.blog)
                this.$router.push({
                name: 'blogs'
            })
            } catch (err) {
                console.log(err)
            }
        }
    },
    components: {
        VueCkeditor
    },
    created () {
    this.config.toolbar = [
        {
        name: "document",
            items: [
                "Source",
                "-",
                "Save",
                "NewPage",
                "Preview",
                "Print",
                "-",
                "Templates"
            ]
        },
        {
            name: "clipboard",
            items: [
                "Cut",
                "Copy",
                "Paste",
                "PasteText",
                "PasteFromWord",
                "-",
                "Undo",
                "Redo"
            ]
        },
        {
            name: "editing",
            items: ["Find", "Replace", "-", "SelectAll", "-", "Scayt"]
        },
        {
            name: "forms",
            items: [
                "Form",
                "Checkbox",
                "Radio",
                "TextField",
                "Textarea",
                "Select",
                "Button",
                "ImageButton",
                "HiddenField"
            ]
        },
        "/",
        {
            name: "basicstyles",
            items: [
                "Bold",
                "Italic",
                "Underline",
                "Strike",
                "Subscript",
                "Superscript",
                "-",
                "CopyFormatting",
                "RemoveFormat"
            ]
        },
        {
            name: "paragraph",
            items: [
                "NumberedList",
                "BulletedList",
                "-",
                "Outdent",
                "Indent",
                "-",
                "Blockquote",
                "CreateDiv",
                "-",
                "JustifyLeft",
                "JustifyCenter",
                "JustifyRight",
                "JustifyBlock",
                "-",
                "BidiLtr",
                "BidiRtl",
                "Language"
            ]
        },
        { name: "links", items: ["Link", "Unlink", "Anchor"] },
        {
            name: "insert",
            items: [
                "Image",
                "Flash",
                "Table",
                "HorizontalRule",
                "Smiley",
                "SpecialChar",
                "PageBreak",
                "Iframe",
                "InsertPre"
            ]
        },
        "/",
        { name: "styles", items: ["Styles", "Format", "Font", "FontSize"]},
        { name: "colors", items: ["TextColor", "BGColor"] },
        { name: "tools", items: ["Maximize", "ShowBlocks"] },
        { name: "about", items: ["About"] }
    ]
    },
    onBlur (editor) {
        console.log(editor);
    },
    onFocus (editor) {
        console.log(editor);
    },
}
</script>
<style scoped>
</style>