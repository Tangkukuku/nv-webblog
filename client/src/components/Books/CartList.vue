<template>
  <div>
    <main-header navsel="back"></main-header>
    <div class="container">
      <div class="cartlist-warpper">
        <!-- cart info -->
        <div v-if="transections.length" class="cart-info container">
          <div class="rows">
            <div class="col-md-12">
              <div class="transection-wrapper">
                <h4>
                  รายละเอียดการสั่งซื้อ
                </h4>
                <ul class="trasection-list">
                  <li v-for="transection in transections" v-bind:key="transection.id">
                    <h4>
                      {{ transection.booktitle }} จํานวน {{ transection.qty}} x {{ transection.prices }}
                    </h4>
                    <h4>email: {{ transection.email }}</h4>
                    <h4>
                      ชื่อ: {{ transection.username }} {{ transection.userlastname }}
                    </h4>
                    <p>
                      <strong>ราคารวม :</strong>
                      {{ transection.qty * transection.prices | getNumberWithCommas }} บาท
                    </p>
                    <p>
                      <strong>สถานะลูกค้า :</strong> {{transection.clientStatus }}
                    </p>
                    <p>
                      <strong>สถานะร้านค้า :</strong> {{ transection.shopStatus }}
                    </p>
                    <p>
                      <button v-on:click.prevent="sendSent(transection.id)" class="btn btnxs btn-success">ยืนยันการส่ง</button>
                    </p>
                    <p>
                      <strong>วันที่ :</strong>
                      {{ transection.createdAt |
                      formatedDate }}
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
  data() {
    return {
      transections: [],
    };
  },
  async created() {
    this.refreshData();
  },
  methods: {
    async refreshData() {
      this.transections = (await BuysService.index()).data;
    },
    async sendSent(id) {
      let transection = {
        id: id,
        shopStatus: "ส่งแล้ว",
      };
      try {
        await BuysService.put(transection);
        this.refreshData();
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>

<style scoped>
.cartlist-warpper {
  margin-top: 80px;
}
.trasection-null {
  border: solid 1px #dfdfdf;
  margin-bottom: 10px;
  padding: 20px;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.1);
  margin-top: 30px;
}
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
  font-family: kanit;
}

</style>