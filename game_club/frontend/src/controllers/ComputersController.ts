import { deleteRequest, getRequest, postRequest, putRequest } from "../axios/http"

export const getComputers = async () => {
    const data = await getRequest('/api/computers');
    if (data) {
        return data
    } else {
        return 'Данных нет'
    }
}

export const getStatus = async () => {
    const data = await getRequest('/api/statuses_computers');
    if (data) {
        return data
    } else {
        return 'Данных нет'
    }
}

export const getCategory = async () => {
    const data = await getRequest('/api/computers_category');
    if (data) {
        return data
    } else {
        return 'Данных нет'
    }
}

export const getStore = async () => {
    const data = await getRequest('/api/store');
    if (data) {
        return data
    } else {
        return 'Данных нет'
    }
}

export const deleteComputers = async (id: string) => {
    const data = await deleteRequest(`/api/computers/delete/${id}`, {}, { id });
    if (data) {
        return data;
    } else {
        return "Не получилось удалить";
    }
};

export const editComputers = async (id: number, name: string, details: string, category: string, status: string, store: string) => {
    const res = await putRequest(`/api/computers/edit/${id}`, {}, { id, name, details, category, status, store });
    if (res) {
        return res;
    } else {
        return "Не получилось отредактировать";
    }
};

export const addComputers = async (name: string, details: string, category: string, status: string, store: string) => {
    const res = await postRequest(`/api/computers/add`, {}, { name, details, category, status, store });
    if (res) {
        const res2 = await getComputers()
        return res2;
    } else {
        return "Не получилось добавить новый компьютер";
    }
};
