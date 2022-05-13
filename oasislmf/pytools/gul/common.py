"""
This file defines the data types that are loaded from the data files.

"""
import numpy as np
import numba as nb

from oasislmf.pytools.getmodel.common import oasis_float, areaperil_int

ITEM_ID_TYPE = nb.types.int32
ITEMS_DATA_MAP_TYPE = nb.types.UniTuple(nb.types.int64, 3)
items_data_type = nb.from_dtype(np.dtype([('item_id', np.int32),
                                          ('damagecdf_i', np.int32),
                                          ('rng_index', np.int32)
                                          ]))

coverage_type = nb.from_dtype(np.dtype([('tiv', np.float),
                                        ('max_items', np.int32),
                                        ('start_items', np.int32),
                                        ('cur_items', np.int32)
                                        ]))

NP_BASE_ARRAY_SIZE = 8
COVERAGE_ID_TYPE = nb.types.int32

# negative sidx (definition)
MEAN_IDX = -1
STD_DEV_IDX = -2
TIV_IDX = -3
CHANCE_OF_LOSS_IDX = -4
MAX_LOSS_IDX = -5

NUM_IDX = 5

ITEM_MAP_KEY_TYPE = nb.types.Tuple((nb.types.uint32, nb.types.int32))
ITEM_MAP_VALUE_TYPE = nb.types.UniTuple(nb.types.int32, 3)

# compute the relative size of oasis_float vs int32
oasis_float_to_int32_size = oasis_float.itemsize // np.int32().itemsize

ProbMean = nb.from_dtype(np.dtype([('prob_to', oasis_float),
                                   ('bin_mean', oasis_float)
                                   ]))

damagecdfrec_stream = nb.from_dtype(np.dtype([('event_id', np.int32),
                                              ('areaperil_id', areaperil_int),
                                              ('vulnerability_id', np.int32)
                                              ]))

damagecdfrec = nb.from_dtype(np.dtype([('areaperil_id', areaperil_int),
                                       ('vulnerability_id', np.int32)
                                       ]))


gulSampleslevelHeader = nb.from_dtype(np.dtype([('event_id', 'i4'),
                                                ('item_id', 'i4'),
                                                ]))
gulSampleslevelHeader_size = gulSampleslevelHeader.size

gulSampleslevelRec = nb.from_dtype(np.dtype([('sidx', 'i4'),
                                             ('loss', oasis_float),
                                             ]))
gulSampleslevelRec_size = gulSampleslevelRec.size

