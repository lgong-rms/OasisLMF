from unittest import main, TestCase

from oasislmf.pytools.getmodel.manager import get_items, get_vulns, Footprint

import numpy as np
import numba as nb
import pyarrow.parquet as pq
from pyarrow import memory_map
from contextlib import ExitStack
from typing import Any


class FootprintReadDescriptor:

    INTRO: str = "You've coded a custom footprint read function in your class and attached the FootprintAdapterMixin."

    @staticmethod
    def _check_output_data(instance: Any) -> Any:
        footprint_index_check: str = "present"
        footprint_check: str = "present"
        num_intensity_bins_check: str = "present"

        if hasattr(instance, 'num_intensity_bins') is False:
            num_intensity_bins_check = "missing"
        if hasattr(instance, 'footprint') is False:
            footprint_check = "missing"
        if hasattr(instance, 'footprint_index') is False:
            footprint_index_check = "missing"

        if "missing" in [footprint_check, footprint_index_check, num_intensity_bins_check]:
            raise NotImplementedError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, this read function does not result in creating all of the needed class attributes please check
                below which attributes the custom read function hasn't created\n
                num_intensity_bins: {num_intensity_bins_check}\n
                footprint: {footprint_check}\n
                footprint_index: {footprint_index_check}\n
                """
            )

    @staticmethod
    def _check_input_attributes(instance: Any) -> Any:
        if hasattr(instance, "static_path") is False:
            raise AttributeError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, your class does not have an attribute called "static_path". Please add this attribute which is 
                a string pointing to the path where the footprint data is. 
                """
            )
        read_function = getattr(instance, "read", None)
        if read_function is None:
            raise AttributeError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, your class does not have a function called "read". Please add this function and ensure that 
                this function populates the attributes for your class below:
                \nnum_intensity_bins
                \nfootprint
                \nfootprint_index\n
                """
            )
        if not callable(read_function):
            raise AttributeError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, you have added an attribute called "read". But this has to be function. This function also 
                has to populate the attributes for your class below:
                num_intensity_bins
                footprint
                footprint_index
                """
            )
        get_event_function = getattr(instance, "get_event", None)
        if get_event_function is None:
            raise AttributeError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, your class does not have a function called "get_event". Please add this function and ensure 
                that the function returns a specific event based off the input parameter "event_id".
                """
            )
        if not callable(get_event_function):
            raise AttributeError(
                f"""
                \n{FootprintReadDescriptor.INTRO}
                However, you have added an attribute called "get_event". Please add this as a function and ensure 
                that the function returns a specific event based off the input parameter "event_id".
                """
            )

    @staticmethod
    def _add_stack(instance: Any) -> None:
        instance.stack = ExitStack()

    def __get__(self, instance, owner):
        self._add_stack(instance=instance)
        self._check_input_attributes(instance=instance)
        instance.read()
        self._check_output_data(instance=instance)


class SomeMixin:

    READ_DESCRIPTOR = FootprintReadDescriptor()

    def __enter__(self):
        _ = self.READ_DESCRIPTOR
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        self.stack.__exit__(exc_type, exc_value, exc_traceback)


class SomeTestCase(SomeMixin):

    def __init__(self):
        self.static_path = "something"

    def read(self):
        self.num_intensity_bins = "something"
        self.footprint = "something"
        self.footprint_index = "something"

    def get_event(self):
        pass


class GetModelTests(TestCase):
    """
    This class can be used to test the get model functions in a testing environment. Running this is an effective way
    for isolated development. Patches and mocks can be used to speed up the development however, the get model is
    functional so mocking is not essential. The functions below are commented out as they will automatically run in
    an continuous integration. However, they can be uncommented and used for debugging and development. The example
    data in this directory has the following config:

    {
        "num_vulnerabilities": 50,
        "num_intensity_bins": 50,
        "num_damage_bins": 50,
        "vulnerability_sparseness": 0.5,
        "num_events": 500,
        "num_areaperils": 100,
        "areaperils_per_event": 100,
        "intensity_sparseness": 0.5,
        "num_periods": 1000,
        "num_locations": 1000,
        "coverages_per_location": 3,
        "num_layers": 1
    }

    The data was generated using the oasislmf-get-model-testing repo and has the following formats:

    CSV => all files
    bin => all files
    parquet => vulnerability only
    """
    def test_init(self):
        test = SomeTestCase()

        with ExitStack() as stack:
            print("starting the context")
            outcome = stack.enter_context(test)
            print("finishing the context")

    def test_footprint(self):
        pass

    # def test_get_vulns(self):
    #     vulns_dict = get_items(input_path="./")[0]
    #     first_outcome = get_vulns(static_path="./static/", vuln_dict=vulns_dict, num_intensity_bins=50,
    #                               ignore_file_type={"parquet"})
    #     vulnerability_array = first_outcome[0]
    #
    #     second_outcome = get_vulns(static_path="./static/", vuln_dict=vulns_dict, num_intensity_bins=50)
    #     second_vulnerability_array = second_outcome[0]
    #     print()
    #     print(second_vulnerability_array)
    #     print(vulnerability_array)


if __name__ == "__main__":
    main()
