/*
    Copyright (C) 2009-2011 Julian Bäume <julian@svg4all.de>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

*/

#ifndef KTECHLAB_CIRCUITMODEL_H
#define KTECHLAB_CIRCUITMODEL_H

#include <interfaces/idocumentmodel.h>
#include "circuitexport.h"

class Circuit;
namespace KTechLab
{

class CIRCUIT_EXPORT CircuitModel : public IDocumentModel
{
public:
    CircuitModel(QDomDocument doc, QObject* parent = 0);

    virtual Qt::ItemFlags flags(const QModelIndex& index) const;

    virtual int columnCount(const QModelIndex& parent = QModelIndex()) const;

    virtual QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;

private:
    bool isItem(const QModelIndex& parent) const;
    Circuit* m_circuit;
};

}

#endif // KTECHLAB_CIRCUITMODEL_H
