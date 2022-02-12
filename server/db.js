const mongoose = require("mongoose");
const dbConn = require("./mongoDBconfig.json");
var jwt = require("jsonwebtoken");

const connString = `mongodb+srv://${dbConn.userName}:${dbConn.password}@cluster0.osntg.mongodb.net/${dbConn.dbName}?retryWrites=true&w=majority`;
const mySecret = "password";
const userSchema = new mongoose.Schema({ email: "string", password: "string" });
const weightSchema = new mongoose.Schema({
  value: "string",
  timeStamp: "string",
});
const User = mongoose.model("User", userSchema);
const Weight = mongoose.model("Weight", weightSchema);

module.exports.connectToDb = async () => {
  try {
    await mongoose.connect(connString, {
      useUnifiedTopology: true,
    });
    console.log("db connected");
  } catch (err) {
    console.error(err);
  }
};

async function findUser(email) {
  return (user = await User.findOne({ email }));
}

module.exports.signup = async (email, password) => {
  if (email && password) {
    try {
      let user = await findUser(email);
      if (user) return { err: "email already exists" };

      user = new User({ email, password });
      await user.save();

      var token = jwt.sign({ id: user.id }, mySecret);
      return { token };
    } catch (err) {
      console.log("err :>> ", err);
      return err;
    }
  } else return "Both email and password are required";
};

module.exports.signin = async (email, password) => {
  if (email && password) {
    try {
      let user = await findUser(email);
      if (!user) return { err: "user does not exist" };
      if (user.password !== password)
        return { err: "Oops, incorrect password" };

      var token = jwt.sign({ id: user.id }, mySecret);
      return { token };
    } catch (err) {
      console.log("err :>> ", err);
      return err;
    }
  } else return "Both email and password are required";
};

module.exports.getWeights = async () => {
  try {
    let weights = await Weight.find({}).sort({ timeStamp: "desc" });
    return weights;
  } catch (err) {
    console.log("err :>> ", err);
    return err;
  }
};

module.exports.createWeight = async (value, timeStamp) => {
  let weight = new Weight({ value, timeStamp });
  try {
    await weight.save();
    return { weight };
  } catch (err) {
    console.log("err :>> ", err);
    return { err };
  }
};

module.exports.updateWeight = async (id, value) => {
  try {
    let result = await Weight.findByIdAndUpdate(id, { value: value });
    return { result };
  } catch (err) {
    console.log("err :>> ", err);
    return { err };
  }
};

module.exports.deleteWeight = async (id) => {
  try {
    let result = await Weight.findByIdAndDelete(id);
    return { result };
  } catch (err) {
    console.log("err :>> ", err);
    return { err };
  }
};
