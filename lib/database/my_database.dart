import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fai/database/model/add_post_model.dart';
import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/debt_model.dart';
import 'package:fai/database/model/invoice_model.dart';
import 'package:fai/database/model/questions_model.dart';
import 'package:fai/database/model/questions_model.dart';
import 'package:fai/database/model/questions_model.dart';
import 'package:fai/database/model/questions_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fai/database/model/Order_Model.dart';
import 'package:fai/database/model/add_product.dart';
import 'package:fai/database/model/cart_item_model.dart';
import 'package:fai/database/model/income_model.dart';
import 'package:fai/database/model/report_model.dart';
import 'package:fai/database/model/target_model.dart';
import '../MyDateUtils.dart';
import 'model/task_model.dart';
import 'model/user_model.dart';

class MyDataBase {
  //CollectionReference
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
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
    return getUserCollection()
        .doc(uid)
        .collection(Income.collectionName)
        .withConverter<Income>(
          fromFirestore: (snapshot, options) =>
              Income.fromFireStore(snapshot.data()),
          toFirestore: (income, options) => income.toFireStore(),
        );
  }
  static CollectionReference<DebtModel> getDebtCollection(String uid) {
    return getUserCollection()
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
    return getUserCollection()
        .doc(uid)
        .collection(Target.collectionName)
        .withConverter<Target>(
          fromFirestore: (snapshot, options) =>
              Target.fromFireStore(snapshot.data()),
          toFirestore: (target, options) => target.toFireStore(),
        );
  }

  static CollectionReference<CartItemsModel> getItemCollection(String uid) {
    return getUserCollection()
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

  static CollectionReference<AddProductModel> getAddProductCollection() {
    return FirebaseFirestore.instance
        .collection(AddProductModel.collectionName)
        .withConverter<AddProductModel>(
          fromFirestore: (snapshot, options) =>
              AddProductModel.fromFireStore(snapshot.data()),
          toFirestore: (add, options) => add.toFireStore(),
        );
  }

  static CollectionReference<OrderModel> getOrderCollection(String uid) {
    return getUserCollection()
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

//user
  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }

  static Future<UserModel?> readUser(String id) async {
    var collection = getUserCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Stream<QuerySnapshot<UserModel>> getUserRealTimeUpdate() {
    return getUserCollection().snapshots();
  }

//task
  static Future<void> addTask(String uid, Task task) {
    var newTask = getTaskCollection(uid).doc();
    task.id = newTask.id;
    return newTask.set(task);
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

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdateInAdmin(String uId,) {
    return getTaskCollection(uId).orderBy("dateTime",descending: true)
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

  static Stream<QuerySnapshot<Target>> getTargetRealTimeUpdate(
    String uId,
  ) {
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

  static Stream<QuerySnapshot<Report>> getReportRealTimeUpdate(
      String uid, String tId) {
    return getReportCollection(uid, tId).snapshots();
  }

//Add Product
  static Future<void> addProduct(AddProductModel addProduct) {
    var addproduct = getAddProductCollection().doc();
    addProduct.id = addproduct.id;
    return addproduct.set(addProduct);
  }

  static Stream<QuerySnapshot<AddProductModel>> getAddProductRealTimeUpdate() {
    return getAddProductCollection().snapshots();
  }

  static Future<void> editProduct(String productId, int price) {
    return getAddProductCollection().doc(productId).update({
      "price": price,
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

  static Stream<QuerySnapshot<CartItemsModel>> getItemRealTimeUpdate(
      String uId) {
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

  static Stream<QuerySnapshot<OrderModel>> getOrderRealTimeUpdate(
      String uId, int date) {
    return getOrderCollection(uId)
        .where("dateTime", isGreaterThanOrEqualTo: date)
        .where("dateTime",
            isLessThan: date + 86400000) // 86400000 ميلي ثانية في يوم واحد
        .snapshots();
  }

  static Future<void> editOrder(
      String uId, String orderID, bool accept, bool state) {
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

}

