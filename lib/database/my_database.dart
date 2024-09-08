import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/database/model/add_post_model.dart';
import 'package:fai/database/model/customer_model.dart';
import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/invoice_model.dart';
import 'package:fai/database/model/questions_model.dart';
import 'package:fai/database/model/Order_Model.dart';
import 'package:fai/database/model/add_product.dart';
import 'package:fai/database/model/cart_item_model.dart';
import 'package:fai/database/model/income_model.dart';
import 'package:fai/database/model/report_model.dart';
import 'package:fai/database/model/target_model.dart';
import '../MyDateUtils.dart';
import 'model/secttions_model.dart';
import 'model/task_model.dart';
import 'model/eng_model.dart';



class MyDataBase {
  //CollectionReference
  // static CollectionReference<EngModel> getUserCollection() {
  //   return FirebaseFirestore.instance
  //       .collection(EngModel.collectionName)
  //       .withConverter<EngModel>(
  //         fromFirestore: (snapshot, options) =>
  //             EngModel.fromFireStore(snapshot.data()),
  //         toFirestore: (user, options) => user.toFireStore(),
  //       );
  // }
  static CollectionReference<CustomerModel> getCustomerCollection() {
    return FirebaseFirestore.instance
        .collection(CustomerModel.collectionName)
        .withConverter<CustomerModel>(
          fromFirestore: (snapshot, options) =>
              CustomerModel.fromFireStore(snapshot.data()),
          toFirestore: (customer, options) => customer.toFireStore(),
        );
  }
  static CollectionReference<AddProductModel> getTimerCollection() {
    return FirebaseFirestore.instance
        .collection(AddProductModel.collectionName)
        .withConverter<AddProductModel>(
          fromFirestore: (snapshot, options) =>
              AddProductModel.fromFireStore(snapshot.data()),
          toFirestore: (customer, options) => customer.toFireStore(),
        );
  }

  static CollectionReference<SectionsModel> getSectionsCollection() {
    return FirebaseFirestore.instance
        .collection(SectionsModel.collectionName)
        .withConverter<SectionsModel>(
      fromFirestore: (snapshot, options) =>
          SectionsModel.fromFireStore(snapshot.data()),
      toFirestore: (sections, options) => sections.toFireStore(),
    );
  }

  static CollectionReference<Task> getTaskCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }
  static CollectionReference<QuestionsModel> getQuestionsCollection() {
         return FirebaseFirestore.instance
        .collection(QuestionsModel.collectionName)
        .withConverter<QuestionsModel>(
      fromFirestore: (snapshot, options) =>
          QuestionsModel.fromFireStore(snapshot.data()),
      toFirestore: (question, options) => question.toFireStore(),
    );
  }

  static CollectionReference<Report> getReportCollection(
      String uid, String tId) {
    return getTaskCollection(uid)
        .doc(tId)
        .collection(Report.collectionName)
        .withConverter<Report>(
          fromFirestore: (snapshot, options) =>
              Report.fromFireStore(snapshot.data()),
          toFirestore: (report, options) => report.toFireStore(),
        );
  }

  static CollectionReference<Income> getIncomeCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(Income.collectionName)
        .withConverter<Income>(
          fromFirestore: (snapshot, options) =>
              Income.fromFireStore(snapshot.data()),
          toFirestore: (income, options) => income.toFireStore(),
        );
  }
  static CollectionReference<DebtModel> getDebtCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(DebtModel.collectionName)
        .withConverter<DebtModel>(
          fromFirestore: (snapshot, options) =>
              DebtModel.fromFireStore(snapshot.data()),
          toFirestore: (dept, options) => dept.toFireStore(),
        );
  }
  static CollectionReference<clientInvoiceModel> getClientInvoiceModelCollection(String uid,String cId) {
    return getDebtCollection(uid)
        .doc(cId)
        .collection(clientInvoiceModel.collectionName)
        .withConverter<clientInvoiceModel>(
          fromFirestore: (snapshot, options) =>
              clientInvoiceModel.fromFireStore(snapshot.data()),
          toFirestore: (clientInvoiceModel, options) => clientInvoiceModel.toFireStore(),
        );
  }

  static CollectionReference<Target> getTargetCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(Target.collectionName)
        .withConverter<Target>(
          fromFirestore: (snapshot, options) =>
              Target.fromFireStore(snapshot.data()),
          toFirestore: (target, options) => target.toFireStore(),
        );
  }

  static CollectionReference<CartItemsModel> getItemCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(CartItemsModel.collectionName)
        .withConverter<CartItemsModel>(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data() as Map<String, dynamic>;
            return CartItemsModel.fromFirestore(data);
          },
          toFirestore: (cartItem, options) => cartItem.toFireStore(),
        );
  }

  static CollectionReference<AddProductModel> getAddProductCollection(
      String secId) {
    return getSectionsCollection()
        .doc(secId)
        .collection(AddProductModel.collectionName)
        .withConverter<AddProductModel>(
      fromFirestore: (snapshot, options) =>
          AddProductModel.fromFireStore(snapshot.data()),
      toFirestore: (product, options) => product.toFireStore(),
    );
  }
  static CollectionReference<OrderModel> getOrderCollection(String uid) {
    return getCustomerCollection()
        .doc(uid)
        .collection(OrderModel.collectionName)
        .withConverter<OrderModel>(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data() as Map<String, dynamic>;
            return OrderModel.fromFireStore(data);
          },
          toFirestore: (order, options) => order.toFirestore(),
        );
  }

  static CollectionReference<AddPostModel> getAddPostCollection() {
    return FirebaseFirestore.instance
        .collection(AddPostModel.collectionName)
        .withConverter<AddPostModel>(
      fromFirestore: (snapshot, options) =>
          AddPostModel.fromFireStore(snapshot.data()),
      toFirestore: (add, options) => add.toFireStore(),
    );
  }

//Eng user
//   static Future<void> addUser(EngModel user) {
//     var collection = getCustomerCollection();
//     return collection.doc(user.id).set(user);
//   }
//
//   static Future<EngModel?> readUser(String id) async {
//     var collection = getUserCollection();
//     var docSnapShot = await collection.doc(id).get();
//     return docSnapShot.data();
//   }
//
//   static Stream<QuerySnapshot<EngModel>> getUserRealTimeUpdate() {
//     return getUserCollection().snapshots();
//   }

  // Customer model
  static Future<void> addCustomer(CustomerModel user) {
    var collection = getCustomerCollection();
    return collection.doc(user.id).set(user);
  }

  static Future<CustomerModel?> readCustomer(String id) async {
    var collection = getCustomerCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<CustomerModel>> getCustomerRealTimeUpdate(String uId) {
    return getCustomerCollection().where("engId", isEqualTo: uId)
        .snapshots();
  }
  static Stream<QuerySnapshot<CustomerModel>> getCustomerRealTimeUpdateInAdmin() {
    return getCustomerCollection().snapshots();
  }
  static Stream<QuerySnapshot<CustomerModel>> getCustomerDataRealTimeUpdate(String uId) {
    return getCustomerCollection().where("id", isEqualTo: uId).snapshots();
  }
  static Future<void> editCustomer( String customerId, bool isFarmer,bool isCustomer) {
    return getCustomerCollection().doc(customerId).update(
      {
        "isFarmer": isFarmer,
        "isCustomer": isCustomer,
      },
    );
  }


//task
  static Future<void> addTask(String uid, Task task) {
    var newTask = getTaskCollection(uid).doc();
    task.id = newTask.id;
    return newTask.set(task);
  }

  static Future<List<Task>> getTasksForDay(String userId, int dayInMillis) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('dateTime', isEqualTo: dayInMillis)
          .get();
      return snapshot.docs.map((doc) => Task.fromFireStore(doc.data())).toList();
    } catch (e) {
      print('Error fetching tasks for day: $e');
      return [];
    }
  }
  static Future<QuerySnapshot<Task>> getTasks(String uId) {
    return getTaskCollection(uId).get();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdate(String uId, int date) {
    return getTaskCollection(uId)
        .orderBy("dateTime",descending: true)
        .where("dateTime", isEqualTo: date)
        .snapshots();
  }
  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdateWithWeek(String uId, int date) {
    int endDate = date + (7 * 24 * 60 * 60 * 1000);
    return getTaskCollection(uId)
        .orderBy("dateTime", descending: false)
        .where("dateTime", isGreaterThanOrEqualTo: date, isLessThanOrEqualTo: endDate)
        .snapshots();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdateInAdmin(String uId,) {
    return getTaskCollection(uId).orderBy("dateTime",descending: false)
        .snapshots();
  }

  static Future<void> deleteTask(String uId, String taskId) {
    return getTaskCollection(uId).doc(taskId).delete();
  }

  static Future<void> editTask(String uId, String taskId, bool isDone) {
    return getTaskCollection(uId).doc(taskId).update(
      {
        "isDone": isDone,
      },
    );
  }

  static Future<void> editTaskIncome(String uId, String taskId, double income) {
    return getTaskCollection(uId).doc(taskId).update(
      {
        "Income": income,
      },
    );
  }

//income

  static Future<void> addIncome(String uid, Income income) {
    var newIncome = getIncomeCollection(uid).doc();
    income.id = newIncome.id;
    return newIncome.set(income);
  }

  static Future<void> editIncome(String Uid, double inCome) {
    return getIncomeCollection(Uid).doc().update({
      "DailyInCome": inCome,
    });
  }

  static Stream<QuerySnapshot<Income>> getIncomeRealTimeUpdate(String uId,) {
    return getIncomeCollection(uId).snapshots();
  }
  static Stream<QuerySnapshot<Income>> getDailyIncomeRealTimeUpdate(String userId, DateTime date) {
    int startOfDay = MyDateUtils.dateOnly(date).millisecondsSinceEpoch;
    int endOfDay = startOfDay + 86400000;

    return getIncomeCollection(userId)
        .where("dateTime", isGreaterThanOrEqualTo: startOfDay)
        .where("dateTime", isLessThan: endOfDay)
        .snapshots();
  }
  static Future<void> deleteIncome(String uId) {
    return getIncomeCollection(uId).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  //target
  static Future<void> addTarget(String uid, Target target) {
    var newTarget = getTargetCollection(uid).doc();
    target.id = newTarget.id;
    return newTarget.set(target);
  }

  static Stream<QuerySnapshot<Target>> getTargetRealTimeUpdate(String uId,) {
    return getTargetCollection(uId).snapshots();
  }

  static Future<void> deleteTarget(String uId) {
    return getTargetCollection(uId).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  //Report
  static Future<void> addReport(String uid, String tId, Report report) {
    var newReport = getReportCollection(uid, tId).doc();
    report.id = newReport.id;
    return newReport.set(report);
  }

  static Stream<QuerySnapshot<Report>> getReportRealTimeUpdate(String uid, String tId) {
    return getReportCollection(uid, tId).snapshots();
  }

//Add Product

  static Future<void> addAddProduct(String secId, AddProductModel product) {
    var newAddProduct = getAddProductCollection(secId).doc();
    product.id = newAddProduct.id;
    return newAddProduct.set(product);
  }
  static Future<void> editProduct(String secId,String productId, int price,String Photo) {
    return getAddProductCollection(secId).doc(productId).update({
      "price": price,
      "imageUrl": Photo,
    });
  }
  static Future<void> deleteProduct(String secId ,String productId) {
    return getAddProductCollection(secId).doc(productId).delete();
  }

  static Future<QuerySnapshot<AddProductModel>> getAddProducts(String secId) {
    return getAddProductCollection(secId).get();
  }

  static Stream<QuerySnapshot<AddProductModel>> getAddProductsRealTimeUpdate(String secId) {
    return getAddProductCollection(secId).orderBy("product",descending: true).snapshots();
  }
  static Stream<QuerySnapshot<AddProductModel>> getAdddddProductsRealTimeUpdate() {
    return getTimerCollection().orderBy("product",descending: true).snapshots();
  }
  static Future<void> deleteProoooduct(String productId) {
    return getTimerCollection().doc(productId).delete();
  }


  static Future<void> editProoooduct(String productId, int price,String des,String Photo) {
    return getTimerCollection().doc(productId).update({
      "price": price,
      "des": des,
      "price": price,
      "imageUrl": Photo,
    });
  }

  //CartItem
  static Future<void> addItemToCart(String uid, CartItemsModel item) {
    var newItem = getItemCollection(uid).doc();
    item.id = newItem.id;
    return newItem.set(item);
  }

  static Future<QuerySnapshot<CartItemsModel>> getItem(String uId) {
    return getItemCollection(uId).get();
  }

  static Stream<QuerySnapshot<CartItemsModel>> getItemRealTimeUpdate(String uId) {
    return getItemCollection(uId).snapshots();
  }

  static Future<void> deleteCartItems(String uId) {
    return getItemCollection(uId).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  //Order
  static Future<void> addOrder(String uid, OrderModel orderModel) {
    var newOrder = getOrderCollection(uid).doc();
    orderModel.id = newOrder.id;
    return newOrder.set(orderModel);
  }

  static Future<QuerySnapshot<OrderModel>> getOrder(String uId) {
    return getOrderCollection(uId).get();
  }

  static Stream<QuerySnapshot<OrderModel>> getOrderRealTimeUpdate(String uId, int date) {
    return getOrderCollection(uId)
        .where("dateTime", isGreaterThanOrEqualTo: date)
        .where("dateTime",
            isLessThan: date + 86400000) // 86400000 ميلي ثانية في يوم واحد
        .snapshots();
  }

  static Future<void> editOrder(String uId, String orderID, bool accept, bool state) {
    return getOrderCollection(uId).doc(orderID).update(
      {
        "accept": accept,
        "state": state,
      },
    );
  }

  //Debt

  static Future<void> addDebt(String uid, DebtModel debt) {
    var newDebt = getDebtCollection(uid).doc();
    debt.id = newDebt.id;
    return newDebt.set(debt);
  }


  static Stream<QuerySnapshot<DebtModel>> getDebtRealTimeUpdate(String uId,) {
    return getDebtCollection(uId).snapshots();
  }

  static Future<void> editDebt(String uId, String debtId, double oldDebt) {
    return getDebtCollection(uId).doc(debtId).update(
      {
        "oldDebt": oldDebt,
      },
    );
  }

  //invoice
  static Future<void> addClientInvoice(String uid, clientInvoiceModel clientInvoice,String cId) {
    var newClientInvoice = getClientInvoiceModelCollection(uid,cId).doc();
    clientInvoice.id = newClientInvoice.id;
    return newClientInvoice.set(clientInvoice);
  }
  static Stream<QuerySnapshot<clientInvoiceModel>> getClientInvoiceRealTimeUpdate(String uId,String cId) {
    return getClientInvoiceModelCollection(uId,cId).snapshots();
  }



  // post
  static Future<void> addAddPost(AddPostModel addPost) {
    var newAddPost = getAddPostCollection().doc();
    addPost.id = newAddPost.id;
    return newAddPost.set(addPost);
  }

  static Future<QuerySnapshot<AddPostModel>> getAddPosts() {
    return getAddPostCollection().get();
  }

  static Stream<QuerySnapshot<AddPostModel>> getAddPostsRealTimeUpdate() {
    return getAddPostCollection()
        .orderBy("dateTime",descending: true)
        // .where("dateTime", isEqualTo: date)
        .snapshots();
  }


  static Future<void> deleteAddPost( String addPostId) {
    return getAddPostCollection().doc(addPostId).delete();
  }

  static Future<void> editAddPost( String addPostId,String postPhoto) {
    return getAddPostCollection().doc(addPostId).update(
      {
        'photo': postPhoto,
      },
    );
  }
  //Questions
  static Future<void> addQuestions(QuestionsModel question) {
    var newQuestions = getQuestionsCollection().doc();
    question.id = newQuestions.id;
    return newQuestions.set(question);
  }

  static Future<QuerySnapshot<QuestionsModel>> getQuestions() {
    return getQuestionsCollection().get();
  }

  static Stream<QuerySnapshot<QuestionsModel>> getQuestionsRealTimeUpdate() {
    return getQuestionsCollection()
        .orderBy("dateTime",descending: true).snapshots();
  }

  static Stream<QuerySnapshot<QuestionsModel>> getQuestionsRealTimeUpdateInAdmin(String uId,) {
    return getQuestionsCollection().orderBy("dateTime",descending: true)
        .snapshots();
  }

  static Future<void> deleteQuestions( String questionId) {
    return getQuestionsCollection().doc(questionId).delete();
  }


  //Sections

  static Future<void> addSections(SectionsModel addSections) {
    var addsections = getSectionsCollection().doc();
    addSections.id = addsections.id;
    return addsections.set(addSections);
  }

  static Future<SectionsModel?> readSections(String id) async {
    var collection = getSectionsCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<SectionsModel>> getSectionsRealTimeUpdate() {
    return getSectionsCollection().snapshots();
  }

}

