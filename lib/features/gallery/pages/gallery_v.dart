import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_bloc.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_event.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_state.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late final GalleryPickerBloc _galleryPickerBloc;

  @override
  void initState() {
    _galleryPickerBloc = context.read<GalleryPickerBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gallery",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          GestureDetector(
            onTap: () => _galleryPickerBloc.add(CameraCapture()),
            child: Icon(Icons.camera),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () => _galleryPickerBloc.add(GalleryImagePicker()),
            child: Icon(Icons.image),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GalleryPickerBloc, GalleryPickerState>(
              builder: (context, state) {
                debugPrint("State : $state");
                if (state.images?.isEmpty ?? true) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Icon(Icons.image_not_supported_outlined, size: 30),
                        SizedBox(height: 16),
                        Text("Please select/capture an image first"),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final isLoadingTile =
                        state.status == GalleryStatus.loading &&
                            index == state.images!.length;

                    if (isLoadingTile) {
                      return Container(
                        alignment: .center,
                        child: const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      );
                    }

                    if (index >= state.images!.length) {
                      return const SizedBox.shrink();
                    }
                    String path = state.images![index];
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: .cover,
                          image: MemoryImage(File(path).readAsBytesSync()),
                        ),
                      ),
                    );
                  },
                  itemCount: (state.images?.length ?? 0) + (state.status == GalleryStatus.loading ? 1 : 0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
