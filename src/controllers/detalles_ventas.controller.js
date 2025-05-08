import { pool } from '../db.js';

// Controlador para obtener los detalles de una venta por numero_factura
export const obtenerDetallesVenta = async (req, res) => {
  const { numero_factura } = req.params; // Obtiene el número de factura de los parámetros de la URL
  try {
    const [result] = await pool.query(
      `
      SELECT 
        dv.ID_Detalle AS id_detalle_venta,
        dv.NumeroFactura AS id_venta,
        dv.ID_Producto,
        dv.Cantidad,
        dv.PrecioVenta ,
        p.nombreProducto,
        p.Descripcion AS descripcion_producto,
        (dv.Cantidad * dv.PrecioVenta) AS total_venta
      FROM Detalle_venta_factura dv
      INNER JOIN Producto p ON dv.ID_Producto = p.ID_Producto
      WHERE dv.NumeroFactura = ?
    `,
      [numero_factura]
    );

    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron detalles para esta venta.',
      });
    }

    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los detalles de la venta.',
      error: error.message,
    });
  }
};
