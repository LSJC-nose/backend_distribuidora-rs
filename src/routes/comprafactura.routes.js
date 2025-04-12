    import { Router } from 'express';
    import { obtenerComprasConDetalles} from '../controllers/comprafactura.controller.js';

    const router = Router();

    // Ruta para obtener todos los clientes
    router.get('/comprafactura', obtenerComprasConDetalles);


    export default router;