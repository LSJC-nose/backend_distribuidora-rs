import { Router } from "express";
import { obtenerProductos, obtenerProducto, registrarProducto, actualizarProducto, eliminarProducto } from "../controllers/productos.controller.js";

const router = Router();

router.get("/productos", obtenerProductos); // Obtener todos los productos
router.get("/producto/:id", obtenerProducto); // Obtener producto por ID
router.post("/producto", registrarProducto); // Registrar nuevo producto
router.patch("/producto/:id", actualizarProducto); // Actualizar producto por ID
router.delete("/producto/:id", eliminarProducto); // Eliminar producto por ID

export default router;
