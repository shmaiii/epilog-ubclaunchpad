import express from "express";

import noLocationController from "../controllers/noLocationController.js";

const router = express.Router();

router.post("/initialize-usa-users", noLocationController.initializeUserUSA);

router.post(
  "/initialize-canada-users",
  noLocationController.initializeUserCanada
);

router.get("/get-user-location", noLocationController.getLocation);
export default router;
