import { TableCell, TableRow } from "@mui/material";
import { GridColDef } from "@mui/x-data-grid";
import React from "react";
import TableData from "../../UI/Table/TableData";
import {
  addComputers,
  deleteComputers,
  editComputers,
  getComputers,
} from "../../controllers/ComputersController";
import Header from "../Header/Header";
import styles from "./Computers.module.sass";
import {getStore, getStatus, getCategory} from "../../controllers/ComputersController";
import {checkIsArrayDataFromModal, uniqArrayForModal} from "../../utills/dataUtil";

const columns: GridColDef[] = [
  { field: "name", headerName: "Название", type: "string" },
  { field: "details", headerName: "Описание", type: "string" },
  { field: "category", headerName: "Категория"},
  { field: "categorySelect", headerName: "Категория", type: "select"},
  { field: "status", headerName: "Статус" },
  { field: "statusSelect", headerName: "Статус", type: "select" },
  { field: "store", headerName: "Склад"},
  { field: "storeSelect", headerName: "Склад", type: "select"}
];

const Computers: React.FC = () => {
  const [store_select, setStore] = React.useState<any>([]);
  const [status_select, setStatus] = React.useState<any>([]);
  const [category_select, setCategory] = React.useState<any>([]);
  const [data, setData] = React.useState([]);
  const [open, setOpen] = React.useState(false);
  const [id, setId] = React.useState<string | undefined>(undefined);
  const [editData, setEditData] = React.useState<any>(null);
  const fetchData = React.useCallback(async () => {
    fetchStore();
    fetchStatus();
    fetchCategory();
    const dataTable = await getComputers();
    if (dataTable.length) {
      setData(dataTable);
    } else {
      setData([]);
    }
  }, []);

  const fetchStore = React.useCallback(async () => {
    const store_select = await getStore();
    if (store_select.length) {
      setStore(store_select);
    } else {
      setStore([]);
    }
  }, []);

  const fetchStatus = React.useCallback(async () => {
    const status_select = await getStatus();
    if (status_select.length) {
      setStatus(status_select);
    } else {
      setStatus([]);
    }
  }, []);

  const fetchCategory = React.useCallback(async () => {
    const category_select = await getCategory();
    if (category_select.length) {
      setCategory(category_select);
    } else {
      setCategory([]);
    }
  }, []);

  const handleOpen = React.useCallback((id?: string) => {
    setOpen((openModal) => !openModal);
    setId(id);
  }, []);

  const handleSetCurrentData = React.useCallback((currentData: any) => {
    let newObj = uniqArrayForModal(store_select, currentData, "store");
    newObj = uniqArrayForModal(status_select, currentData, "status");
    newObj = uniqArrayForModal(category_select, currentData, "category");
    setEditData(newObj);
  }, [store_select, status_select,  category_select]);

  const handleAdd = React.useCallback((data: any) => {
    addComputers(
        data.name,
        data.details,
        checkIsArrayDataFromModal(data.categorySelect),
        checkIsArrayDataFromModal(data.statusSelect),
        checkIsArrayDataFromModal(data.storeSelect),
    );
  }, []);

  const handleEdit = React.useCallback(
      (data: any) => {
        editComputers(
            data.id,
            data.name,
            data.details,
            checkIsArrayDataFromModal(data.categorySelect),
            checkIsArrayDataFromModal(data.statusSelect),
            checkIsArrayDataFromModal(data.storeSelect),
        );
        fetchData();
        setOpen(false);
      },
      [fetchData]
  );

  const handleDelete = React.useCallback(async () => {
    if (id) {
      const data = await deleteComputers(id);
      await fetchData();
      if (data) setOpen(false);
    }
  }, [fetchData, id]);

  React.useEffect(() => {
    fetchData();
  }, [fetchData, open]);
  return (
      <>
        <Header />
        <h2 className={styles.booking_title}>Computers</h2>
        <TableData
            columns={columns}
            openModal={open}
            data={editData || {
              storeSelect: store_select,
              statusSelect: status_select,
              categorySelect: category_select,
            }}
            handleEdit={handleEdit}
            handleAdd={handleAdd}
            handleClose={handleOpen}
            handleDelete={handleDelete}>
          {data.length &&
              data.map((row: any, index: number) => (
                  <TableRow
                      key={`${row.id}${index}`}
                      sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                      className={styles.table_cell}
                      onClick={() => {
                        handleOpen(row.id);
                        handleSetCurrentData(row);
                      }}>
                    <TableCell align="left">{row.name}</TableCell>
                    <TableCell align="left">{row.details}</TableCell>
                    <TableCell align="left">{row.category}</TableCell>
                    <TableCell align="left">{row.status}</TableCell>
                    <TableCell align="left">{row.store}</TableCell>
                  </TableRow>
              ))}
        </TableData>
      </>
  );
};
export default Computers;
