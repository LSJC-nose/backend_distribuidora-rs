import { Router } from 'express';
import { 
  obtenerProveedor, 
  obtenerProveedorid, 
  registrarProveedor, 
  actualizarProveedor, 
  eliminarProveedor 
} from '../controllers/proveedor.controller.js';

const router = Router(); // Inicialización de rutas

// Ruta para registrar un proveedor
router.post('/registrarproveedor', registrarProveedor);

// Ruta para obtener todos los proveedores
router.get('/proveedor', obtenerProveedor);

// Ruta para obtener un proveedor por su ID
router.get('/proveedor/:id', obtenerProveedorid);

// Ruta para actualizar un proveedor por su ID
router.patch('/actualizarproveedor/:id', actualizarProveedor);

// Ruta para eliminar un proveedor por su ID
router.delete('/eliminarproveedor/:id', eliminarProveedor);

export default router;
