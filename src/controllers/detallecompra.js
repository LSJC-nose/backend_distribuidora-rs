
import { pool } from '../db.js';

// Controlador para obtener los detalles de una compra por id_compra
export const obtenerDetallesCompra = async (req, res) => {
  const { ID_CompraFactura } = req.params; // Obtiene el id de los parámetros de la URL
  try {
    const [result] = await pool.query(
      `
     SELECT
    dcf.ID_CompraFactura,
    dcf.ID_Producto,
    dcf.ID_Compra,
    prod.nombreProducto,
    dcf.Cantidad,
    dcf.PrecioCompra,
    (dcf.Cantidad * dcf.PrecioCompra) AS Subtotal
FROM
    DetalleCompraFactura dcf 
JOIN
    Producto prod ON dcf.ID_Producto = prod.ID_Producto
     WHERE dcf.ID_CompraFactura = ?

    `,
      [ID_CompraFactura]
    );

    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron detalles para esta compra.',
      });
    }

    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los detalles de la compra.',
      error: error.message,
    });
  }
};
