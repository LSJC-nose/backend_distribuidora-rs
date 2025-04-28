import { Router } from 'express';
import {  obtenerCategoria,
   obtenerCategoriaid,
    registrarCategoria,
    eliminarCategoria,
    actualizarCategoria
     } from '../controllers/categoria.controller.js';

const router = Router();

// Ruta para obtener todas las categorias
router.get('/categorias', obtenerCategoria);

// Ruta para obtener todos los clientes id
router.get('/categorias/:id', obtenerCategoriaid);

router.post('/registrarcategorias', registrarCategoria);

router.delete('/eliminarcategoria/:id', eliminarCategoria);

router.patch('/actualizarcategoria/:id', actualizarCategoria);

export default router;