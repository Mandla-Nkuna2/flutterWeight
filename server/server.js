const express = require("express");
const db = require("./db");
const swaggerJsdoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
const app = express();
db.connectToDb();
const iosPort = 5000;
const andPort = 8081;

app.use(express.json({ extended: false }));
const swaggerOptions = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Weight API",
      version: "1.0.0",
    },
  },
  apis: ["./server/server.js"],
};
const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs));

/**
 * @swagger
 * /:
 *   get:
 *     summary: Test api
 *     responses:
 *       200:
 *         description: Welcome to flutter app
 */
app.get("/", (req, res) => {
  res.send("Welcome to the flutter weight app");
});
/**
 * @swagger
 * /sign_up:
 *   post:
 *     summary: Create account
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: Your email
 *               password:
 *                  type: string
 *                  description: Your password
 *     responses:
 *       201:
 *          description: Created
 */
app.post("/sign_up", async (req, resp) => {
  const { email, password } = req.body;
  let result = await db.signup(email, password);

  if (result.token) resp.status(201).json({ token: result.token });
  else resp.status(400).json({ err: result });
});
/**
 * @swagger
 * /login:
 *   post:
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: Your email
 *               password:
 *                  type: string
 *                  description: Your password
 *     responses:
 *       201:
 *          description: Logged in
 */
app.post("/login", async (req, resp) => {
  // resp.status(201).json({ token: "0123456789" });
  const { email, password } = req.body;
  let result = await db.signin(email, password);

  if (result.token) resp.status(201).json({ token: result.token });
  else if (result.err) resp.status(400).json({ err: result.err });
});
/**
 * @swagger
 * /get_weight_history:
 *   get:
 *     summary: Get weight history
 *     responses:
 *       200:
 *         description: Success
 */
app.get("/get_weight_history", async (req, resp) => {
  let result = await db.getWeights();

  if (result.err) resp.status(400).json(result.err);
  else resp.status(200).json(result);
});
/**
 * @swagger
 * /save_weight:
 *   post:
 *     summary: Add new weight
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               value:
 *                 type: integer
 *                 description: Weight value
 *               timeStamp:
 *                  type: string
 *                  description: Current date and time
 *     responses:
 *       201:
 *          description: Created
 */
app.post("/save_weight", async (req, resp) => {
  const { value, timeStamp } = req.body;
  let result = await db.createWeight(value, timeStamp);

  if (result.err) resp.status(400).json({ err: result.err });
  else resp.status(201).json(result.weight);
});
/**
 * @swagger
 * /update_weight/{id}:
 *   put:
 *     summary: Update weight
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID of the weight to update.
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *          schema:
 *           properties:
 *               value:
 *                 type: integer
 *                 description: Weight value
 *     responses:
 *       201:
 *          description: Updated
 */
app.put("/update_weight/:id", async (req, resp) => {
  let result = await db.updateWeight(req.params.id, req.body.value);

  if (result.err) resp.status(400).json(result.err);
  else resp.status(201).json(result.result);
});
/**
 * @swagger
 * /delete_weight/{id}:
 *   delete:
 *     summary: Delete weight
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID of the weight to update.
 *         schema:
 *           type: string
 *     responses:
 *       201:
 *          description: Deleted
 */
app.delete("/delete_weight/:id", async (req, resp) => {
  let result = await db.deleteWeight(req.params.id);

  if (result.err) resp.status(400).json(result.err);
  else resp.status(201).json(result.result);
});

app.listen(andPort, () => {
  console.log(`Example app listening on port ${andPort}`);
});
