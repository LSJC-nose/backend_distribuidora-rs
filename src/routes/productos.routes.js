import { Router } from "express";
import { obtenerProductos, 
  obtenerProductoId, 
  registrarProducto, 
  actualizarProductos, 
  eliminarProducto } from "../controllers/productos.controller.js";

const router = Router();

router.get("/productos", obtenerProductos); // Obtener todos los productos
router.get("/producto/:id", obtenerProductoId); // Obtener producto por ID
router.post("/registrarproducto", registrarProducto); // Registrar nuevo producto
router.patch("/actualizarproductos/:id", actualizarProductos); // Actualizar producto por ID
router.delete("/eliminarproducto/:id", eliminarProducto); // Eliminar producto por ID

export default router;
