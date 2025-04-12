import { pool } from '../db.js';

// Obtener todos llas categorias
export const obtenerTipoCliente= async (req, res) => {
  try {
    const [result] = await pool.query('select * from tipoCliente');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos del tipo_Cliente.',
      error: error
    });
  }
};