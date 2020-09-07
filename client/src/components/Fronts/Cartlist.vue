<template>
  <div id="carlist">
    <main-header navsel="front"></main-header>
    <div class="user-info">
      <br />
      <br />
      <h1>แสดงข้อมูลผู้ใช้งาน</h1>
      <div class="form-wrapper" v-if="user != null">
        <div class="form-horizontal">
          <div class="form-group">
            <label for class="control-label col-md-2">Name:</label>
            <div class="col-md-8">
              <input class="form-control" type="text" v-model="user.name" disabled />
            </div>
          </div>
          <div class="form-group">
            <label for class="control-label col-md-2">Lastname:</label>
            <div class="col-md-8">
              <input class="form-control" type="text" v-model="user.lastname" disabled />
            </div>
          </div>
          <div class="form-group">
            <label for class="control-label col-md-2">Email:</label>
            <div class="col-md-8">
              <input class="form-control" type="email" v-model="user.email" disabled />
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- cart info -->
    <div v-if="transections.length" class="cart-info container">
      <div class="rows">
        <div class="col-md-12">
          <div class="transection-wrapper">
            <h4>รายละเอียดการสั่ง</h4>
            <ul class="trasection-list">
              <li v-for="transection in transections" v-bind:key="transection.id">
                <h4>{{ transection.booktitle }} จํานวน {{ transection.qty}} x {{ transection.prices }}</h4>
                <p>
                  <strong>ราคารวม :</strong>
                  {{ transection.qty * transection.prices | getNumberWithCommas }} บาท
                </p>
                <p>
                  <strong>สถานะลูกค้า :</strong>
                  {{ transection.clientStatus}}
                </p>
                <p>
                  <button v-on:click.prevent="sendPaid(transection.id)" class="btn btnxs btn-success">ยืนยันการชําระเงิน</button>
                </p>
                <p>
                  <strong>สถานะร้านค้า :</strong>
                  {{ transection.shopStatus}}
                </p>
                <p>
                  <strong>วันที่ :</strong>
                  {{ transection.createdAt | formatedDate }}
                </p>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div v-else class="container">
      <div class="trasection-null">ไม่มีรายการสั่งซื้อขณะนี้</div>
    </div>
  </div>
</template>
<script>
import { mapState } from "vuex";
import BuysService from "@/services/BuysService";
import moment from "moment";
export default {
  filters: {
    formatedDate(value) {
      return moment(String(value)).format("DD-MM-YYYY");
    },
    getNumberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
  computed: {
    ...mapState(["isUserLoggedIn", "user"]),
  },
  data() {
    return {
      transections: [],
    };
  },
  async created() {
    this.transections = (await BuysService.user(this.user.id)).data;
    console.log(this.transections);
  },
  mounted() {
    if (!this.isUserLoggedIn) {
      
      alert("Please, Register or Login before.\n\nThank you.");
      this.$router.push({
        name: "front",
      });
    }
  },
  methods: {
    async sendPaid(id) {
      let transection = {
        id: id,
        clientStatus: "ชําระแล้ว",
      };
      try {
        await BuysService.put(transection);
        this.refreshData();
      } catch (error) {
        console.log(error);
      }
    },
    async refreshData() {
      this.transections = (await BuysService.user(this.user.id)).data;
    },
  },
  
};
</script>
<style scoped>
.user-info h1 {
  text-align: center;
}
.trasection-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.trasection-list li {
  border: solid 1px #dfdfdf;
  margin-bottom: 10px;
  padding: 20px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.1);
}
.cart-info {
  margin-top: 50px;
}
.trasection-null {
  border: solid 1px #dfdfdf;
  margin-bottom: 10px;
  padding: 20px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.1);
  margin-top: 30px;
}
</style>