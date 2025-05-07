import { Router } from "express";
import { obtenerProductos, 
  obtenerProductoId, 
  registrarProducto, 
  actualizarProducto, 
  eliminarProducto } from "../controllers/productos.controller.js";

const router = Router();

router.get("/productos", obtenerProductos); // Obtener todos los productos
router.get("/producto/:id", obtenerProductoId); // Obtener producto por ID
router.post("/registrarproducto", registrarProducto); // Registrar nuevo producto
router.patch("/actualizarproducto/:id", actualizarProducto); // Actualizar producto por ID
router.delete("/eliminarproducto/:id", eliminarProducto); // Eliminar producto por ID

export default router;
