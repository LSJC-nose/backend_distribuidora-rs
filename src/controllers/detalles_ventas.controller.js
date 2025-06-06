

import { pool } from '../db.js';

// Obtener todos los clientes
export const obtenerDetalle= async (req, res) => {
  const { NumeroFactura } = req.params; 
  try {
    const [result] = await pool.query(
    `
      SELECT 
        dv.ID_Detalle ,
        dv.NumeroFactura AS id_venta,
        dv.ID_Producto,
        dv.Cantidad,
        dv.PrecioVenta ,
        p.nombreProducto,
        p.Descripcion ,
        (dv.Cantidad * dv.PrecioVenta) AS total_venta
      FROM Detalle_venta_factura dv
      INNER JOIN Producto p ON dv.ID_Producto = p.ID_Producto
      WHERE dv.NumeroFactura = ?
    `,
      [NumeroFactura]
    );

    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron detalles para esta venta.',
      });
    }

    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de ldetalle.',
      error: error
    });
  }
};