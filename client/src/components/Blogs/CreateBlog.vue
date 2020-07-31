<template>
    <div>
        <h1>Create Blog</h1>
        <form v-on:submit.prevent = "createBlog">
            <p>title: <input type="text" v-model="blog.title"></p>
            <transition name="fade">
                <div class="thumbnail-pic" v-if="blog.thumbnail != 'null'">
                    <img :src="BASE_URL+blog.thumbnail" alt="thumbnail">
                </div>
            </transition>           
            <form enctype="multipart/form-data" novalidate>
                <div class="dropbox">
                    <input type="file" multiple :name="uploadFieldName" :disabled="isSaving" @change="filesChange($event.target.name,$event.target.files); fileCount = $event.target.files.length" accept="image/*" class="input-file">
                    <!-- <p v-if="isInitial || isSuccess"> -->
                    <p v-if="isInitial">
                        Drag your file(s) here to begin<br> or click to browse
                    </p>
                    <p v-if="isSaving">
                        Uploading {{ fileCount }} files...
                    </p>
                    <p v-if="isSuccess">
                        Upload Successful.
                    </p>
                </div>
            </form>
            <div>
                <transition-group tag="ul" name="fade" class="pictures">
                    <li v-for="picture in pictures" v-bind:key="picture.id">
                        <img style="margin-bottom:5px;" :src="BASE_URL+picture.name" alt="picture image">
                    <br>
                    <button v-on:click.prevent="useThumbnail(picture.name)">Thumbnail</button>
                    <button v-on:click.prevent="delFile(picture)">Delete</button>
                    </li>
                </transition-group>
                <div class="clearfix"></div>
            </div> 
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
import UploadService from '@/services/UploadService'
    const STATUS_INITIAL = 0,
    STATUS_SAVING = 1,
    STATUS_SUCCESS = 2,
    STATUS_FAILED = 3
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
                BASE_URL: "http://localhost:8081/assets/uploads/",
                error: null,
                // uploadedFiles: [],
                uploadError: null,
                currentStatus: null,
                uploadFieldName: "userPhoto",
                uploadedFileNames:[],
                pictures: [],
                pictureIndex: 0
            }
        },
        methods: {
            async editBlog () {
                try {
                    await BlogsService.put(this.blog)
                    this.$router.push({
                    name: 'blogs'
                })
                } catch (err) {
                    console.log(err)
                }
            },
            async delFile (material){
                let result = confirm("Want to delete?")
                if (result) {
                    let dataJSON = {
                        "filename":material.name
                    }

                    await UploadService.delete(dataJSON)

                    for (var i=0;i<this.pictures.length;i++){
                        if(this.pictures[i].id === material.id) {
                            this.pictures.splice(i, 1)
                            this.materialIndex--
                            break
                        }
                    }
                }
            },
            async createBlog () {
                this.blog.pictures = JSON.stringify(this.pictures)
                try {
                    await BlogsService.post(this.blog)
                    this.$router.push({
                    name: 'blogs'
                })
                } catch (err) {
                    console.log(err)
                }
            },
            // upload
            wait(ms) {
                return x => {
                    return new Promise(resolve => setTimeout(() => resolve(x), ms));
                };
            },
            reset() {
                // reset form to initial state
                this.currentStatus = STATUS_INITIAL
                // this.uploadedFiles = []
                this.uploadError = null
                this.uploadedFileNames = []
            },
            async save(formData) {
                // upload data to the server
                try {
                    this.currentStatus = STATUS_SAVING
                    await UploadService.upload(formData)
                    this.currentStatus = STATUS_SUCCESS
                    // update image uploaded display
                    let pictureJSON = []
                    this.uploadedFileNames.forEach(uploadFilename => {
                        let found = false;
                        for(let i=0;i<this.pictures.length;i++){
                            if(this.pictures[i].name == uploadFilename){ 
                                found = true
                                break
                            }
                        }
                        if(!found){
                            this.pictureIndex++
                            let pictureJSON = {
                                id: this.pictureIndex,
                                name: uploadFilename
                            }
                            this.pictures.push(pictureJSON)
                        }
                    })
                    this.clearUploadResult()
                } catch (error) {
                    console.log(error)
                    this.currentStatus = STATUS_FAILED
                }
            },
            filesChange(fieldName, fileList) {
                // handle file changes
                const formData = new FormData();
                if (!fileList.length) return;
                // append the files to FormData
                Array.from(Array(fileList.length).keys()).map(x => {
                    formData.append(fieldName, fileList[x], fileList[x].name);
                    this.uploadedFileNames.push(fileList[x].name);
                });
                // save it
                this.save(formData);
            },
            clearUploadResult: function(){
                setTimeout(() => this.reset(), 5000);
            },
            useThumbnail (filename) {
                console.log(filename)
                this.blog.thumbnail = filename
            },
        },
        components: {
            VueCkeditor
        },
        computed: {
            isInitial() {
                return this.currentStatus === STATUS_INITIAL;
            },
            isSaving() {
                return this.currentStatus === STATUS_SAVING;
            },
            isSuccess() {
                return this.currentStatus === STATUS_SUCCESS;
            },
            isFailed() {
                return this.currentStatus === STATUS_FAILED;
            }
        },
        created () {
        this.reset()
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
    /* uplaod */
    .dropbox {
        outline: 2px dashed grey; /* the dash box */
        outline-offset: -10px;
        background:lemonchiffon;
        color: dimgray;
        padding: 10px 10px;
        min-height: 200px; /* minimum height */
        position: relative;
        cursor: pointer;
    }

    .input-file {
        opacity: 0; /* invisible but it's there! */
        width: 100%;
        height: 200px;
        position: absolute;
        cursor: pointer;
    }

    .dropbox:hover {
        background:khaki; /* when mouse over to the drop zone, change color*/
    }

    .dropbox p {
        font-size: 1.2em;
        text-align: center;
        padding: 50px 0;
    }

    ul.pictures {
        list-style: none;
        padding: 0;
        margin: 0;
        float: left;
        padding-top: 10px;
        padding-bottom: 10px;
    }

    ul.pictures li {
        float: left;
    }

    ul.pictures li img {
        max-width: 180px;
        margin-right: 20px;
    }

    .clearfix {
        clear: both;
    }

    /* thumbnail */
    .thumbnail-pic img{
        width:200px;
    }
</style>