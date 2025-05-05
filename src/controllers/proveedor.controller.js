import { pool } from '../db.js';

// Obtener todos los proveedores
export const obtenerProveedor = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM Proveedores');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de los proveedores.',
      error: error
    });
  }
};

// Obtener un proveedor por su ID
export const obtenerProveedorid = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM proveedor WHERE ID_Proveedores = ?', [req.params.id]);

    if (result.length <= 0) {
      return res.status(404).json({
        mensaje: `Error al leer los datos. El ID ${req.params.id} del proveedor no fue encontrado.`
      });
    }
    res.json(result[0]);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos del proveedor.'
    });
  }
};

// Registrar un nuevo proveedor
export const registrarProveedor = async (req, res) => {
  try {
    const { NombreProveedor, Telefono, Correo, Direccion } = req.body;

    if (!NombreProveedor || !Telefono || !Correo || !Direccion) {
      return res.status(400).json({ mensaje: 'Todos los campos son obligatorios.' });
    }

    const [result] = await pool.query(
      'INSERT INTO proveedores (NombreProveedor, Telefono, Correo, Direccion) VALUES (?, ?, ?, ?)',
      [NombreProveedor, Telefono, Correo, Direccion]
    );

    res.status(201).json({ ID_Proveedores: result.insertId, mensaje: 'Proveedor registrado exitosamente' });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar al proveedor.',
      error: error.message
    });
  }
};

// Actualizar un proveedor por su ID
export const actualizarProveedor = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;

    const [resultado] = await pool.query('UPDATE proveedores SET ? WHERE ID_Proveedores = ?', [datos, id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ mensaje: `El proveedor con ID ${id} no existe.` });
    }

    res.status(200).json({ mensaje: 'Proveedor actualizado exitosamente' });
  } catch (error) {
    return res.status(500).json({ mensaje: 'Error al actualizar el proveedor.', error: error.message });
  }
};

// Eliminar un proveedor por su ID
export const eliminarProveedor = async (req, res) => {
  try {
    const { id } = req.params;

    const [resultado] = await pool.query('DELETE FROM proveedores WHERE ID_Proveedores = ?', [id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ mensaje: `No se encontró el proveedor con ID ${id}.` });
    }

    res.status(204).send();
  } catch (error) {
    return res.status(500).json({ mensaje: 'Error al eliminar el proveedor.', error: error.message });
  }
};
